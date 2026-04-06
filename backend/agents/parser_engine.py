"""
Agent 1: Parser Engine
Parses JSON, XML, CSV files with automatic schema detection and drift handling.
Handles nested structures and mixed data types.
"""

import json
import csv
import xml.etree.ElementTree as ET
from typing import Dict, List, Any, Optional, Tuple
from dataclasses import dataclass, field
from datetime import datetime
import re
import os


@dataclass
class SchemaField:
    """Represents a detected field in the schema"""
    name: str
    data_type: str
    nullable: bool = True
    sample_values: List[Any] = field(default_factory=list)
    nested_schema: Optional[Dict] = None


@dataclass
class ParseResult:
    """Result of parsing operation"""
    success: bool
    records: List[Dict[str, Any]]
    schema: Dict[str, SchemaField]
    file_type: str
    record_count: int
    errors: List[str] = field(default_factory=list)
    schema_drift_detected: bool = False
    drift_details: List[str] = field(default_factory=list)


class ParserEngine:
    """
    Agent 1: Intelligent Parser Engine
    
    Capabilities:
    - Auto-detects file format (JSON, XML, CSV)
    - Handles nested structures up to 10 levels deep
    - Detects schema drift across records
    - Infers data types with confidence scoring
    - Flattens nested structures for relational mapping
    """
    
    SUPPORTED_FORMATS = ['json', 'xml', 'csv']
    MAX_NESTING_DEPTH = 10
    
    def __init__(self):
        self.detected_schema = {}
        self.type_inference_samples = 100
        
    def parse(self, file_path: str) -> ParseResult:
        """
        Main entry point - auto-detects format and parses file
        """
        if not os.path.exists(file_path):
            return ParseResult(
                success=False,
                records=[],
                schema={},
                file_type="unknown",
                record_count=0,
                errors=[f"File not found: {file_path}"]
            )
        
        file_type = self._detect_file_type(file_path)
        
        if file_type == 'json':
            return self._parse_json(file_path)
        elif file_type == 'xml':
            return self._parse_xml(file_path)
        elif file_type == 'csv':
            return self._parse_csv(file_path)
        else:
            return ParseResult(
                success=False,
                records=[],
                schema={},
                file_type="unknown",
                record_count=0,
                errors=[f"Unsupported file format: {file_type}"]
            )
    
    def parse_content(self, content: str, file_type: str) -> ParseResult:
        """
        Parse content directly (for API uploads)
        """
        if file_type == 'json':
            return self._parse_json_content(content)
        elif file_type == 'xml':
            return self._parse_xml_content(content)
        elif file_type == 'csv':
            return self._parse_csv_content(content)
        else:
            return ParseResult(
                success=False,
                records=[],
                schema={},
                file_type="unknown",
                record_count=0,
                errors=[f"Unsupported format: {file_type}"]
            )
    
    def _detect_file_type(self, file_path: str) -> str:
        """Detect file type from extension and content"""
        ext = os.path.splitext(file_path)[1].lower()
        
        if ext in ['.json']:
            return 'json'
        elif ext in ['.xml']:
            return 'xml'
        elif ext in ['.csv', '.tsv']:
            return 'csv'
        
        # Try content-based detection
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                first_chars = f.read(100).strip()
                
            if first_chars.startswith('{') or first_chars.startswith('['):
                return 'json'
            elif first_chars.startswith('<?xml') or first_chars.startswith('<'):
                return 'xml'
            else:
                return 'csv'
        except:
            return 'unknown'
    
    def _parse_json(self, file_path: str) -> ParseResult:
        """Parse JSON file"""
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
            return self._parse_json_content(content)
        except Exception as e:
            return ParseResult(
                success=False, records=[], schema={},
                file_type='json', record_count=0,
                errors=[f"JSON parse error: {str(e)}"]
            )
    
    def _parse_json_content(self, content: str) -> ParseResult:
        """Parse JSON content string"""
        try:
            data = json.loads(content)
            
            # Handle both array and single object
            if isinstance(data, list):
                records = data
            elif isinstance(data, dict):
                # Check if it's a wrapper with data array
                for key in ['data', 'records', 'items', 'results']:
                    if key in data and isinstance(data[key], list):
                        records = data[key]
                        break
                else:
                    records = [data]
            else:
                records = [{'value': data}]
            
            # Flatten nested structures
            flat_records = [self._flatten_record(r) for r in records]
            
            # Detect schema
            schema = self._detect_schema(flat_records)
            
            # Check for schema drift
            drift_detected, drift_details = self._check_schema_drift(flat_records, schema)
            
            return ParseResult(
                success=True,
                records=flat_records,
                schema=schema,
                file_type='json',
                record_count=len(flat_records),
                schema_drift_detected=drift_detected,
                drift_details=drift_details
            )
        except json.JSONDecodeError as e:
            return ParseResult(
                success=False, records=[], schema={},
                file_type='json', record_count=0,
                errors=[f"Invalid JSON: {str(e)}"]
            )
    
    def _parse_xml(self, file_path: str) -> ParseResult:
        """Parse XML file"""
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
            return self._parse_xml_content(content)
        except Exception as e:
            return ParseResult(
                success=False, records=[], schema={},
                file_type='xml', record_count=0,
                errors=[f"XML parse error: {str(e)}"]
            )
    
    def _parse_xml_content(self, content: str) -> ParseResult:
        """Parse XML content string"""
        try:
            root = ET.fromstring(content)
            records = []
            
            # Find repeating elements (likely data records)
            child_tags = {}
            for child in root:
                tag = child.tag.split('}')[-1] if '}' in child.tag else child.tag
                child_tags[tag] = child_tags.get(tag, 0) + 1
            
            # Use the most frequent child tag as record container
            if child_tags:
                record_tag = max(child_tags, key=child_tags.get)
                for elem in root.findall(f".//{record_tag}"):
                    record = self._xml_element_to_dict(elem)
                    records.append(record)
            else:
                records = [self._xml_element_to_dict(root)]
            
            flat_records = [self._flatten_record(r) for r in records]
            schema = self._detect_schema(flat_records)
            drift_detected, drift_details = self._check_schema_drift(flat_records, schema)
            
            return ParseResult(
                success=True,
                records=flat_records,
                schema=schema,
                file_type='xml',
                record_count=len(flat_records),
                schema_drift_detected=drift_detected,
                drift_details=drift_details
            )
        except ET.ParseError as e:
            return ParseResult(
                success=False, records=[], schema={},
                file_type='xml', record_count=0,
                errors=[f"Invalid XML: {str(e)}"]
            )
    
    def _xml_element_to_dict(self, elem, depth=0) -> Dict:
        """Convert XML element to dictionary"""
        if depth > self.MAX_NESTING_DEPTH:
            return {'_value': ET.tostring(elem, encoding='unicode')}
        
        result = {}
        
        # Add attributes
        for key, val in elem.attrib.items():
            result[f"@{key}"] = val
        
        # Add children
        children = list(elem)
        if children:
            child_dict = {}
            for child in children:
                tag = child.tag.split('}')[-1] if '}' in child.tag else child.tag
                child_data = self._xml_element_to_dict(child, depth + 1)
                
                if tag in child_dict:
                    if not isinstance(child_dict[tag], list):
                        child_dict[tag] = [child_dict[tag]]
                    child_dict[tag].append(child_data)
                else:
                    child_dict[tag] = child_data
            result.update(child_dict)
        elif elem.text and elem.text.strip():
            result['_text'] = elem.text.strip()
        
        return result if result else {'_text': elem.text.strip() if elem.text else ''}
    
    def _parse_csv(self, file_path: str) -> ParseResult:
        """Parse CSV file"""
        try:
            with open(file_path, 'r', encoding='utf-8', newline='') as f:
                content = f.read()
            return self._parse_csv_content(content)
        except Exception as e:
            return ParseResult(
                success=False, records=[], schema={},
                file_type='csv', record_count=0,
                errors=[f"CSV parse error: {str(e)}"]
            )
    
    def _parse_csv_content(self, content: str) -> ParseResult:
        """Parse CSV content string"""
        try:
            # Detect delimiter
            sniffer = csv.Sniffer()
            try:
                dialect = sniffer.sniff(content[:2048])
            except:
                dialect = csv.excel
            
            lines = content.strip().split('\n')
            reader = csv.DictReader(lines, dialect=dialect)
            records = list(reader)
            
            # Clean up field names
            cleaned_records = []
            for record in records:
                cleaned = {}
                for key, value in record.items():
                    clean_key = key.strip() if key else f"column_{len(cleaned)}"
                    cleaned[clean_key] = value.strip() if value else None
                cleaned_records.append(cleaned)
            
            schema = self._detect_schema(cleaned_records)
            drift_detected, drift_details = self._check_schema_drift(cleaned_records, schema)
            
            return ParseResult(
                success=True,
                records=cleaned_records,
                schema=schema,
                file_type='csv',
                record_count=len(cleaned_records),
                schema_drift_detected=drift_detected,
                drift_details=drift_details
            )
        except Exception as e:
            return ParseResult(
                success=False, records=[], schema={},
                file_type='csv', record_count=0,
                errors=[f"CSV parse error: {str(e)}"]
            )
    
    def _flatten_record(self, record: Dict, prefix: str = '', depth: int = 0) -> Dict:
        """Flatten nested dictionary structure"""
        if depth > self.MAX_NESTING_DEPTH:
            return {prefix.rstrip('_'): str(record)}
        
        flat = {}
        for key, value in record.items():
            new_key = f"{prefix}{key}" if prefix else key
            
            if isinstance(value, dict):
                flat.update(self._flatten_record(value, f"{new_key}_", depth + 1))
            elif isinstance(value, list):
                if all(isinstance(item, dict) for item in value):
                    # Array of objects - store as JSON string for now
                    flat[new_key] = json.dumps(value)
                else:
                    flat[new_key] = json.dumps(value)
            else:
                flat[new_key] = value
        
        return flat
    
    def _detect_schema(self, records: List[Dict]) -> Dict[str, SchemaField]:
        """Detect schema from records with type inference"""
        schema = {}
        
        for record in records[:self.type_inference_samples]:
            for field_name, value in record.items():
                if field_name not in schema:
                    schema[field_name] = SchemaField(
                        name=field_name,
                        data_type=self._infer_type(value),
                        nullable=value is None or value == '',
                        sample_values=[value] if value else []
                    )
                else:
                    # Update type inference
                    current_type = schema[field_name].data_type
                    new_type = self._infer_type(value)
                    
                    if value is None or value == '':
                        schema[field_name].nullable = True
                    else:
                        if len(schema[field_name].sample_values) < 5:
                            schema[field_name].sample_values.append(value)
                    
                    # Handle type conflicts
                    if current_type != new_type and value is not None:
                        schema[field_name].data_type = self._resolve_type_conflict(
                            current_type, new_type
                        )
        
        return schema
    
    def _infer_type(self, value: Any) -> str:
        """Infer data type from value"""
        if value is None or value == '':
            return 'NULL'
        
        if isinstance(value, bool):
            return 'BOOLEAN'
        if isinstance(value, int):
            return 'INTEGER'
        if isinstance(value, float):
            return 'FLOAT'
        
        str_val = str(value).strip()
        
        # Try integer
        try:
            int(str_val)
            return 'INTEGER'
        except:
            pass
        
        # Try float
        try:
            float(str_val)
            return 'FLOAT'
        except:
            pass
        
        # Try boolean
        if str_val.lower() in ('true', 'false', 'yes', 'no', '1', '0'):
            return 'BOOLEAN'
        
        # Try date patterns
        date_patterns = [
            r'^\d{4}-\d{2}-\d{2}$',  # YYYY-MM-DD
            r'^\d{2}/\d{2}/\d{4}$',  # MM/DD/YYYY
            r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}',  # ISO datetime
        ]
        for pattern in date_patterns:
            if re.match(pattern, str_val):
                return 'DATETIME' if 'T' in str_val else 'DATE'
        
        # Try email
        if re.match(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$', str_val):
            return 'EMAIL'
        
        # Try JSON array/object
        if (str_val.startswith('[') and str_val.endswith(']')) or \
           (str_val.startswith('{') and str_val.endswith('}')):
            return 'JSON'
        
        # Default to string with length hint
        length = len(str_val)
        if length <= 50:
            return 'VARCHAR(50)'
        elif length <= 255:
            return 'VARCHAR(255)'
        else:
            return 'TEXT'
    
    def _resolve_type_conflict(self, type1: str, type2: str) -> str:
        """Resolve conflicting type inferences"""
        type_hierarchy = ['TEXT', 'VARCHAR(255)', 'VARCHAR(50)', 'JSON', 
                          'DATETIME', 'DATE', 'EMAIL', 'FLOAT', 'INTEGER', 'BOOLEAN', 'NULL']
        
        if type1 == 'NULL':
            return type2
        if type2 == 'NULL':
            return type1
        
        # INTEGER can be promoted to FLOAT
        if {type1, type2} == {'INTEGER', 'FLOAT'}:
            return 'FLOAT'
        
        # Different string types -> use larger
        if 'VARCHAR' in type1 and 'VARCHAR' in type2:
            return 'VARCHAR(255)'
        
        # Fallback to TEXT for incompatible types
        return 'TEXT'
    
    def _check_schema_drift(self, records: List[Dict], schema: Dict[str, SchemaField]) -> Tuple[bool, List[str]]:
        """Check for schema drift across records"""
        drift_detected = False
        drift_details = []
        
        expected_fields = set(schema.keys())
        
        for i, record in enumerate(records):
            record_fields = set(record.keys())
            
            # Check for missing fields
            missing = expected_fields - record_fields
            if missing:
                drift_detected = True
                drift_details.append(f"Record {i}: Missing fields: {missing}")
            
            # Check for extra fields
            extra = record_fields - expected_fields
            if extra:
                drift_detected = True
                drift_details.append(f"Record {i}: Extra fields: {extra}")
                # Add to schema
                for field in extra:
                    schema[field] = SchemaField(
                        name=field,
                        data_type=self._infer_type(record.get(field)),
                        nullable=True,
                        sample_values=[record.get(field)]
                    )
        
        return drift_detected, drift_details[:10]  # Limit details
    
    def get_schema_summary(self, schema: Dict[str, SchemaField]) -> Dict:
        """Get human-readable schema summary"""
        return {
            field_name: {
                'type': field.data_type,
                'nullable': field.nullable,
                'samples': field.sample_values[:3]
            }
            for field_name, field in schema.items()
        }

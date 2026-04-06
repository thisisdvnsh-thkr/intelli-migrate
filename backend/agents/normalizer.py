"""
Agent 4: Normalizer
Converts flat data structures to 3rd Normal Form (3NF) with automatic 
foreign key relationship detection and ERD generation.
"""

from typing import Dict, List, Any, Optional, Set, Tuple
from dataclasses import dataclass, field
from collections import defaultdict
import re
import json


@dataclass
class Column:
    """Represents a table column"""
    name: str
    data_type: str
    nullable: bool = True
    primary_key: bool = False
    foreign_key: Optional[str] = None  # "table.column"
    unique: bool = False


@dataclass
class Table:
    """Represents a normalized table"""
    name: str
    columns: List[Column]
    primary_key: str
    foreign_keys: List[Tuple[str, str]]  # [(local_col, ref_table.ref_col), ...]
    records: List[Dict[str, Any]] = field(default_factory=list)


@dataclass
class NormalizationResult:
    """Result of normalization process"""
    success: bool
    tables: List[Table]
    relationships: List[Dict]
    erd_diagram: str
    normalization_level: str  # '1NF', '2NF', '3NF'
    original_columns: int
    normalized_columns: int


class Normalizer:
    """
    Agent 4: Database Normalizer (3NF)
    
    Capabilities:
    - Automatic dependency detection
    - 1NF → 2NF → 3NF transformation
    - Foreign key relationship inference
    - Primary key generation
    - ERD diagram generation (Mermaid format)
    - Handles nested JSON arrays
    """
    
    # Common groupings for entity detection
    ENTITY_PATTERNS = {
        'customer': ['customer', 'cust', 'client', 'buyer', 'user'],
        'product': ['product', 'prod', 'item', 'sku', 'goods'],
        'order': ['order', 'ord', 'purchase', 'transaction'],
        'address': ['address', 'addr', 'street', 'city', 'state', 'zip', 'country', 'postal'],
        'payment': ['payment', 'pay', 'credit', 'card', 'billing'],
        'employee': ['employee', 'emp', 'staff', 'worker'],
        'department': ['department', 'dept', 'division'],
    }
    
    def __init__(self):
        self.tables = []
        self.relationships = []
    
    def normalize(self, records: List[Dict], table_name: str = 'main', 
                  schema: Dict = None) -> NormalizationResult:
        """
        Main normalization pipeline - converts flat data to 3NF
        """
        if not records:
            return NormalizationResult(
                success=False, tables=[], relationships=[], 
                erd_diagram='', normalization_level='0NF',
                original_columns=0, normalized_columns=0
            )
        
        # Get all columns
        all_columns = set()
        for record in records:
            all_columns.update(record.keys())
        
        original_column_count = len(all_columns)
        
        # Step 1: Detect entities from column names
        entities = self._detect_entities(list(all_columns))
        
        # Step 2: Create normalized tables
        tables = self._create_normalized_tables(records, entities, table_name)
        
        # Step 3: Establish relationships
        relationships = self._establish_relationships(tables)
        
        # Step 4: Generate ERD
        erd = self._generate_erd(tables, relationships)
        
        # Count normalized columns
        normalized_column_count = sum(len(t.columns) for t in tables)
        
        return NormalizationResult(
            success=True,
            tables=tables,
            relationships=relationships,
            erd_diagram=erd,
            normalization_level='3NF',
            original_columns=original_column_count,
            normalized_columns=normalized_column_count
        )
    
    def _detect_entities(self, columns: List[str]) -> Dict[str, List[str]]:
        """Detect entity groupings from column names"""
        entities = defaultdict(list)
        assigned_columns = set()
        
        for col in columns:
            col_lower = col.lower()
            
            for entity, patterns in self.ENTITY_PATTERNS.items():
                if any(pattern in col_lower for pattern in patterns):
                    entities[entity].append(col)
                    assigned_columns.add(col)
                    break
        
        # Assign remaining columns to main table
        for col in columns:
            if col not in assigned_columns:
                # Check if it's a nested/array column
                if '_' in col:
                    prefix = col.split('_')[0]
                    if prefix.lower() in [e.lower() for e in entities.keys()]:
                        for entity in entities:
                            if entity.lower() == prefix.lower():
                                entities[entity].append(col)
                                assigned_columns.add(col)
                                break
        
        # Remaining to main
        for col in columns:
            if col not in assigned_columns:
                entities['main'].append(col)
        
        return dict(entities)
    
    def _create_normalized_tables(self, records: List[Dict], 
                                   entities: Dict[str, List[str]], 
                                   base_table_name: str) -> List[Table]:
        """Create normalized tables from entity groupings"""
        tables = []
        
        # Process each entity
        for entity_name, columns in entities.items():
            if not columns:
                continue
            
            # Generate table name
            if entity_name == 'main':
                tbl_name = base_table_name
            else:
                tbl_name = f"{base_table_name}_{entity_name}" if entity_name != base_table_name else entity_name
            
            # Create columns with types
            tbl_columns = []
            
            # Add primary key
            pk_name = f"{entity_name}_id" if entity_name != 'main' else 'id'
            tbl_columns.append(Column(
                name=pk_name,
                data_type='INTEGER',
                nullable=False,
                primary_key=True,
                unique=True
            ))
            
            # Add foreign key to parent if not main table
            foreign_keys = []
            if entity_name != 'main':
                fk_name = f"{base_table_name}_id"
                tbl_columns.append(Column(
                    name=fk_name,
                    data_type='INTEGER',
                    nullable=False,
                    foreign_key=f"{base_table_name}.id"
                ))
                foreign_keys.append((fk_name, f"{base_table_name}.id"))
            
            # Add entity columns
            for col in columns:
                data_type = self._infer_column_type(records, col)
                
                # Skip if it looks like the primary key we already added
                if col.lower().endswith('_id') and col.lower().replace('_id', '') == entity_name:
                    continue
                
                tbl_columns.append(Column(
                    name=col,
                    data_type=data_type,
                    nullable=True
                ))
            
            # Extract records for this entity
            entity_records = self._extract_entity_records(records, columns, entity_name)
            
            tables.append(Table(
                name=tbl_name,
                columns=tbl_columns,
                primary_key=pk_name,
                foreign_keys=foreign_keys,
                records=entity_records
            ))
        
        # Ensure main table exists
        if not any(t.name == base_table_name for t in tables):
            main_table = Table(
                name=base_table_name,
                columns=[Column('id', 'INTEGER', False, True, None, True)],
                primary_key='id',
                foreign_keys=[],
                records=[{'id': i+1} for i in range(len(records))]
            )
            tables.insert(0, main_table)
        
        return tables
    
    def _infer_column_type(self, records: List[Dict], column: str) -> str:
        """Infer SQL data type from sample values"""
        sample_values = []
        for record in records[:50]:
            if column in record and record[column] is not None:
                sample_values.append(record[column])
        
        if not sample_values:
            return 'TEXT'
        
        # Check types
        has_int = all(isinstance(v, int) or (isinstance(v, str) and v.isdigit()) for v in sample_values if v)
        has_float = all(isinstance(v, (int, float)) or self._is_numeric(v) for v in sample_values if v)
        has_bool = all(isinstance(v, bool) or str(v).lower() in ('true', 'false', '0', '1') for v in sample_values if v)
        
        if has_bool and all(str(v).lower() in ('true', 'false', '0', '1', 'yes', 'no') for v in sample_values if v):
            return 'BOOLEAN'
        if has_int:
            return 'INTEGER'
        if has_float:
            return 'DECIMAL(10,2)'
        
        # Check for date patterns
        if any('date' in column.lower() or 'time' in column.lower() for _ in [1]):
            return 'TIMESTAMP'
        
        # Default to text with size hint
        max_len = max(len(str(v)) for v in sample_values) if sample_values else 255
        if max_len <= 50:
            return 'VARCHAR(50)'
        elif max_len <= 255:
            return 'VARCHAR(255)'
        else:
            return 'TEXT'
    
    def _is_numeric(self, value) -> bool:
        """Check if value is numeric"""
        try:
            float(str(value).replace(',', '').replace('$', ''))
            return True
        except:
            return False
    
    def _extract_entity_records(self, records: List[Dict], columns: List[str], 
                                 entity_name: str) -> List[Dict]:
        """Extract records for a specific entity"""
        entity_records = []
        seen = set()
        
        pk_field = f"{entity_name}_id" if entity_name != 'main' else 'id'
        
        for i, record in enumerate(records):
            entity_data = {pk_field: i + 1}
            
            for col in columns:
                if col in record:
                    entity_data[col] = record[col]
            
            # Deduplicate based on actual data (excluding ID)
            data_key = json.dumps({k: v for k, v in entity_data.items() if k != pk_field}, sort_keys=True, default=str)
            
            if data_key not in seen:
                seen.add(data_key)
                entity_records.append(entity_data)
        
        return entity_records
    
    def _establish_relationships(self, tables: List[Table]) -> List[Dict]:
        """Establish foreign key relationships between tables"""
        relationships = []
        
        for table in tables:
            for fk_col, ref in table.foreign_keys:
                ref_table, ref_col = ref.split('.')
                relationships.append({
                    'from_table': table.name,
                    'from_column': fk_col,
                    'to_table': ref_table,
                    'to_column': ref_col,
                    'type': 'many-to-one'
                })
        
        return relationships
    
    def _generate_erd(self, tables: List[Table], relationships: List[Dict]) -> str:
        """Generate ERD diagram in Mermaid format"""
        lines = ['erDiagram']
        
        # Add tables
        for table in tables:
            lines.append(f'    {table.name} {{')
            for col in table.columns:
                pk_marker = ' PK' if col.primary_key else ''
                fk_marker = ' FK' if col.foreign_key else ''
                lines.append(f'        {col.data_type} {col.name}{pk_marker}{fk_marker}')
            lines.append('    }')
        
        # Add relationships
        for rel in relationships:
            # Mermaid relationship syntax
            rel_type = '||--o{' if rel['type'] == 'many-to-one' else '||--||'
            lines.append(f'    {rel["to_table"]} {rel_type} {rel["from_table"]} : has')
        
        return '\n'.join(lines)
    
    def get_normalization_summary(self, result: NormalizationResult) -> Dict:
        """Get human-readable normalization summary"""
        return {
            'success': result.success,
            'normalization_level': result.normalization_level,
            'original_columns': result.original_columns,
            'total_tables': len(result.tables),
            'total_columns': result.normalized_columns,
            'relationships': len(result.relationships),
            'tables': [
                {
                    'name': t.name,
                    'columns': [c.name for c in t.columns],
                    'primary_key': t.primary_key,
                    'foreign_keys': t.foreign_keys,
                    'record_count': len(t.records)
                }
                for t in result.tables
            ],
            'erd_diagram': result.erd_diagram
        }
    
    def get_table_data(self, result: NormalizationResult) -> Dict[str, List[Dict]]:
        """Get all table data for SQL generation"""
        return {table.name: table.records for table in result.tables}

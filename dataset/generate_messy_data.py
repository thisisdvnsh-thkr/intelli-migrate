"""
Sample Data Generator for Intelli-Migrate Testing
Generates messy e-commerce data with intentional anomalies
"""

import json
import csv
import random
import string
from datetime import datetime, timedelta
import os

# Configuration
NUM_RECORDS = 100
ANOMALY_RATE = 0.15  # 15% of records will have anomalies

# Sample data pools
FIRST_NAMES = ['John', 'Jane', 'Michael', 'Sarah', 'David', 'Emily', 'Robert', 'Lisa', 'William', 'Jennifer']
LAST_NAMES = ['Smith', 'Johnson', 'Williams', 'Brown', 'Jones', 'Garcia', 'Miller', 'Davis', 'Rodriguez', 'Martinez']
PRODUCTS = [
    ('Laptop', 999.99, 'Electronics'),
    ('Smartphone', 699.99, 'Electronics'),
    ('Headphones', 149.99, 'Electronics'),
    ('Coffee Maker', 79.99, 'Kitchen'),
    ('Blender', 49.99, 'Kitchen'),
    ('Running Shoes', 129.99, 'Sports'),
    ('Yoga Mat', 29.99, 'Sports'),
    ('Desk Chair', 249.99, 'Furniture'),
    ('Monitor', 399.99, 'Electronics'),
    ('Keyboard', 89.99, 'Electronics'),
]
CITIES = ['New York', 'Los Angeles', 'Chicago', 'Houston', 'Phoenix', 'Philadelphia', 'San Antonio', 'San Diego']
STATES = ['NY', 'CA', 'IL', 'TX', 'AZ', 'PA', 'TX', 'CA']

def generate_messy_email(name):
    """Generate email with occasional errors"""
    domains = ['gmail.com', 'yahoo.com', 'outlook.com', 'email.com']
    base = name.lower().replace(' ', '.')
    
    if random.random() < 0.1:  # 10% invalid emails
        return random.choice([
            f'{base}@',  # Missing domain
            f'{base}gmail.com',  # Missing @
            f'@{domains[0]}',  # Missing local part
            'invalid-email',  # Completely invalid
        ])
    return f'{base}{random.randint(1, 999)}@{random.choice(domains)}'

def generate_messy_phone():
    """Generate phone with occasional format issues"""
    formats = [
        lambda: f'{random.randint(100, 999)}-{random.randint(100, 999)}-{random.randint(1000, 9999)}',
        lambda: f'({random.randint(100, 999)}) {random.randint(100, 999)}-{random.randint(1000, 9999)}',
        lambda: f'+1{random.randint(1000000000, 9999999999)}',
        lambda: f'{random.randint(1000000000, 9999999999)}',
    ]
    
    if random.random() < 0.1:  # 10% invalid phones
        return random.choice(['123', 'call-me', '', 'N/A', '000-000-0000'])
    return random.choice(formats)()

def generate_messy_date():
    """Generate date with occasional format inconsistencies"""
    base_date = datetime.now() - timedelta(days=random.randint(1, 365))
    formats = [
        '%Y-%m-%d',  # ISO
        '%m/%d/%Y',  # US
        '%d-%m-%Y',  # EU
        '%Y-%m-%dT%H:%M:%S',  # ISO with time
    ]
    
    if random.random() < 0.05:  # 5% invalid dates
        return random.choice(['not-a-date', '2024-13-45', '', 'TBD'])
    return base_date.strftime(random.choice(formats))

def generate_record(record_id):
    """Generate a single messy record"""
    first_name = random.choice(FIRST_NAMES)
    last_name = random.choice(LAST_NAMES)
    product = random.choice(PRODUCTS)
    city_idx = random.randint(0, len(CITIES) - 1)
    
    # Use messy column names (abbreviations, inconsistent casing)
    # Use consistent schema for CSV compatibility
    record = {
        'cust_id': record_id,
        'cust_nm': f'{first_name} {last_name}',
        'email_addr': generate_messy_email(f'{first_name}{last_name}'),
        'phone_no': generate_messy_phone(),
        'addr': f'{random.randint(100, 9999)} {random.choice(["Main", "Oak", "Elm", "Park"])} St',
        'City': CITIES[city_idx],
        'ST': STATES[city_idx],
        'ZIP': f'{random.randint(10000, 99999)}',
        'ord_dt': generate_messy_date(),
        'prod_nm': product[0],
        'prod_cat': product[2],
        'qty': random.randint(1, 5),
        'unit_price': product[1],
        'total_amt': None,  # Will calculate
    }
    
    # Calculate total
    record['total_amt'] = round(record['qty'] * record['unit_price'], 2)
    
    # Introduce anomalies
    if random.random() < ANOMALY_RATE:
        anomaly_type = random.choice(['negative_qty', 'null_value', 'extreme_value', 'duplicate_id', 'type_error'])
        
        if anomaly_type == 'negative_qty':
            record['qty'] = -random.randint(1, 5)
        elif anomaly_type == 'null_value':
            null_field = random.choice([k for k in record.keys() if k not in ['cust_id']])
            record[null_field] = None
        elif anomaly_type == 'extreme_value':
            record['unit_price'] = random.choice([0, 999999.99, -100])
        elif anomaly_type == 'type_error':
            record['qty'] = 'many'  # String instead of number
    
    return record

def generate_dataset():
    """Generate complete dataset"""
    records = [generate_record(i + 1) for i in range(NUM_RECORDS)]
    return records

def save_json(records, filename):
    """Save as JSON"""
    with open(filename, 'w', encoding='utf-8') as f:
        json.dump(records, f, indent=2, default=str)
    print(f'✅ Created {filename} ({len(records)} records)')

def save_csv(records, filename):
    """Save as CSV"""
    if not records:
        return
    
    fieldnames = list(records[0].keys())
    with open(filename, 'w', newline='', encoding='utf-8') as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(records)
    print(f'✅ Created {filename} ({len(records)} records)')

def save_xml(records, filename):
    """Save as XML"""
    lines = ['<?xml version="1.0" encoding="UTF-8"?>', '<orders>']
    
    for record in records:
        lines.append('  <order>')
        for key, value in record.items():
            safe_value = str(value).replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;') if value else ''
            lines.append(f'    <{key}>{safe_value}</{key}>')
        lines.append('  </order>')
    
    lines.append('</orders>')
    
    with open(filename, 'w', encoding='utf-8') as f:
        f.write('\n'.join(lines))
    print(f'✅ Created {filename} ({len(records)} records)')

def main():
    print('\n🔧 Generating Sample Data for Intelli-Migrate\n')
    print(f'   Records: {NUM_RECORDS}')
    print(f'   Anomaly Rate: {ANOMALY_RATE * 100}%\n')
    
    # Generate data
    records = generate_dataset()
    
    # Get output directory
    script_dir = os.path.dirname(os.path.abspath(__file__))
    
    # Save in multiple formats
    save_json(records, os.path.join(script_dir, 'messy_ecommerce.json'))
    save_csv(records, os.path.join(script_dir, 'messy_ecommerce.csv'))
    save_xml(records, os.path.join(script_dir, 'messy_ecommerce.xml'))
    
    # Also create a clean version for comparison
    clean_records = [r for r in records if all(v is not None for v in r.values())][:50]
    save_json(clean_records, os.path.join(script_dir, 'clean_ecommerce.json'))
    
    print(f'\n✅ Done! Files created in: {script_dir}')
    print('\nTo test Intelli-Migrate:')
    print('1. Start the backend: cd backend && uvicorn main:app --reload')
    print('2. Open frontend: open frontend/index.html')
    print('3. Upload messy_ecommerce.json and watch the magic! 🎉\n')

if __name__ == '__main__':
    main()

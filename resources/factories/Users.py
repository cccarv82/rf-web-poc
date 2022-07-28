from faker import Faker
fake = Faker(['pt_BR'])


def factory_users(type):
    data = {
        'admin': {
            'login': 'admin@bodytest.com',
            'password': 'pwd123'
        },
        'student': {
            'name': fake.name(),
            'email': fake.email(),
            'age': fake.pyint(min_value=18, max_value=100),
            'weight': fake.pyfloat(right_digits=1, min_value=30, max_value=400),
            'feet_tall': fake.pyfloat(right_digits=2, min_value=1, max_value=3)
        }
    }
    return data[type]

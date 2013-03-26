#Database information

class Configuration(object):
    DATABASE = {
        'engine': 'peewee.MySQLDatabase',
        'name': 'pd_test',
        'user': 'pd_tester',
        'passwd': 'Nuggets',
        'host': 'bmw.stanford.edu'
        }
    DEBUG = True 
    SECRET_KEY = 'StephenTrusheim'

class LocalConfiguration(object):
    DATABASE = {
        'engine': 'peewee.MySQLDatabase',
        'name': 'pd_test',
        'user': 'root',
        'passwd': 'root',
        }
    DEBUG = True 
    SECRET_KEY = 'StephenTrusheim'

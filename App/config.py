import os
basedir = os.path.abspath(os.path.dirname(__file__))

class Config(object):
    DEBUG = False
    TESTING = False
    CSRF_ENABLED = True
    #Database URL
    SQLALCHEMY_DATABASE_URI = 'postgresql://postgres:postgres@localhost:5432/my_app_db'


class DevelopmentConfig(Config):
    DEVELOPMENT = True
    DEBUG = True

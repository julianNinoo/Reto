# RetoAddi
RetoAddi

Para ver el nombre http://stage.quantil.co/getn/hola
Para ver el id http://stage.quantil.co/get/2
Para ver todo http://stage.quantil.co/getall
Para añadir http://stage.quantil.co/add?name=alejandrasanchez&money=010

¿Qué se ha hecho? 
- Se instaló python3.6 y nginx
- Se creó un archivo .env con este contenido:export APP_SETTINGS=config.DevelopmentConfig
- Se instala el ambiente con: virtualenv -p python3 venv
- Se activa el ambiente: source venv/bin/activate
- Se añade la variable:
echo "source `which activate.sh`" >> ~/.bashrc
source ~/.bashrc
echo $APP_SETTINGS
source venv/bin/activate

- En el archivo config.py se agregó esto:
SQLALCHEMY_DATABASE_URI = 'postgresql://postgres:postgres@localhost:5432/my_app_db'

- Se tenía este error: sqlalchemy.exc.InvalidRequestError: Table 'clients' is already defined for this MetaData instance.  Specify 'extend_existing=True' to redefine options and columns on an existing Table object.
 se solucionó así: se agregó
__table_args__ = {'extend_existing': True}
justo debajo de  __tablename__

- En el archivo app.py se cambio la linea que dice: 

from models import Client por import models 
todo lo que dice Client como metodo declarativo , se puso así: models.Client , ejemplo: client=Client.query.filter_by(id=id_).first() se cambió  client=models.Client.query.filter_by(name=name_).first

El anterior cambio se hizo porque no estaba tirando un error que no encontraba el Client en el momento de hacer python3 app.py

¿Como usar Postgres?

Resumen de instrucciones de psql
Tarea	Función psql
Cerrar conexión	\q
Cambiar de Base de datos	\c __base_datos__
Listar Bases de datos	\l
Ver Definiciones	\d __table__
Listar Schemas	\dn
Listar funciones	\df
Listar Vistas	\dv
Ver código SLQ de la función	\df+ __function
Pretty-format	\x


Para terraform se uso este video: https://www.youtube.com/watch?v=O05KkBlAuFg 
https://cloud.google.com/community/tutorials/getting-started-on-gcp-with-terraform guia de GCP + terraform 


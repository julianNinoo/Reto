# RetoAddi
RetoAddi

- Para ver el nombre http://julian.quantil.co/getn/hola
- Para ver el id http://julian.quantil.co/get/2
- Para ver todo http://julian.quantil.co/getall
- Para añadir http://julian.quantil.co/add?name=alejandrasanchez&money=010

# ¿Qué se hizo?

## Paso 1: Modificar la aplicación para que funcione. 

Primero se corrigió la aplicación entregada, de la siguiente manera:
- Se instaló postgres y se creó una base de datos llamada my_app_db. En el archivo **config.py** se agregó lo siguiente:
SQLALCHEMY_DATABASE_URI = 'postgresql://postgres:postgres@localhost:5432/my_app_db'
- Se creó un archivo .env con este contenido:export APP_SETTINGS=config.DevelopmentConfig, debido a que esa variable es utilizada en el código.
- En el archivo app.py se cambio la linea que dice: 
from models import Client por import models 
todo lo que dice Client como metodo declarativo , se puso así: models.Client , ejemplo: client=Client.query.filter_by(id=id_).first() se cambió a client=models.Client.query.filter_by(name=name_).first
- El anterior cambio se hizo porque estaba generando un error en el cual no encontraba el Client.
- Se generaba el error: sqlalchemy.exc.InvalidRequestError: Table 'clients' is already defined for this MetaData instance.  Specify 'extend_existing=True' to redefine options and columns on an existing Table object.
- Lo anterior se solucionó con: __table_args__ = {'extend_existing': True} justo debajo de  __tablename__
- 
### Postdata
- Resumen de instrucciones de postgres:
- Cerrar conexión	\q
- Cambiar de Base de datos	\c __base_datos__
- Listar Bases de datos	\l
- Ver Definiciones	\d __table__


## Paso 2: Desplegar la infraestructura con Terraform

- En la carpeta terraform se encuentra un archivo llamado main.tf en el cual se crea la maquina virtual y la VPC que se usará para la aplicación.
- El archivo main.tf se corrió desde el cloudshell de google cloud, por esta razón es importante crear una cuenta de servicio y darle permisos de IAM a esa cuenta de servicio.
- El archivo .json que se encuentra en la carpeta terraform es la key de la cuenta de servicio.

Problemas obtenidos con terraform:

- Error: Error loading zone 'us-central1-a': googleapi: Error 403: Permission denied on resource project ., forbidden
- Solución: Se solucionó creando una cuenta de servicio con diferentes permisos en IAM, recordar qué cuando se define el proyecto en el main.ts se ponen las comillas dobles ""





### Bibliografía 

https://www.youtube.com/watch?v=O05KkBlAuFg  (Terraform) 
https://cloud.google.com/community/tutorials/getting-started-on-gcp-with-terraform  (guia de GCP + terraform )




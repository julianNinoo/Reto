# RetoAddi

- La app se encuentra funcionando en http://julian.quantil.co
- Para consultar un nombre http://julian.quantil.co/getn/hola
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

### Postdata
- Resumen de instrucciones de postgres:
- Cerrar conexión	\q
- Cambiar de Base de datos	\c __base_datos__
- Listar Bases de datos	\l
- Ver Definiciones	\d __table__

## Paso 2: Escoger el Cloud Provider

Se escogió Google Cloud Platform para aprovechar los 300 créditos que dan para usar sus recursos.

- A continuación se muestra su uso:

![](Imagenes/google.png)


## Paso 3: Desplegar la infraestructura con Terraform

- En la carpeta terraform se encuentra un archivo llamado main.tf en el cual se crea la maquina virtual y la VPC que se usará para la aplicación.
- El archivo main.tf se corrió desde el cloudshell de google cloud, por esta razón es importante crear una cuenta de servicio y darle permisos de IAM a esa cuenta de servicio.
- El archivo .json que se encuentra en la carpeta terraform es la key de la cuenta de servicio.

Problemas obtenidos con terraform:

- Error: Error loading zone 'us-central1-a': googleapi: Error 403: Permission denied on resource project ., forbidden
- Solución: Se solucionó creando una cuenta de servicio con diferentes permisos en IAM, recordar qué cuando se define el proyecto en el main.ts se ponen las comillas dobles ""

- A continuación se muestra el despliegue con terraform:

![](Imagenes/terraformfuncionando.png)

- Cuando se creen los recursos es necesario añadir la siguiente  regla en el firewall de  la red para poder ingresar a las máquinas virtuales por este protocolo.

![](Imagenes/Reglamaquina.png)


## Paso 4: Hacer el manejo de la configuración con Ansible

- Con ansible se instalan todos los servicios necesarios para que la app funcione, en este caso se instaló: Docker, nginx, Jenkins, Postgres y  herramienta de monitoreo.
- Para que ansible no tenga problemas , es necesario pasarle la llave ssh en el comando ansible-playbook, de la siguiente manera:

                                        ansible-playbook nginx.yml  --private-key "/home/julian_nino/llave.key"
                                        
- En el archivo hosts que está en la carpeta de ansible es necesario añadirle un interprete, en este caso python.
- A continuación se muestra la instalación de servicios con Ansible

![](Imagenes/ansible.png)


## Paso 5: Dockerizar la aplicación

- Se toma la decisión de dockerizar para automatizar el despliegue de la aplicación
- Como la base de datos se maneja local entonces es necesario hacer el comando docker run de la siguiente manera:
                            
                              docker run -d  --network=host -p 5000:5000 julian:1.0.1

- A continuación se muestra el contenedor en Up 

![](Imagenes/docker.png)


## Paso 6: Realizar CI/CD

- Se toma la decisión de hacer la integración continua con Jenkins, el archivo Jenkinsfile se puede observar en este repositorio.

- A continuación se muestra la configuración de jenkins:

![](Imagenes/jenkinsconfiguracion.png)

- A continuación se muestra jenkins en funcionamiento con sus stages.

![](Imagenes/jenkins.png)

- Es importante recordar que por la opción settings-Webhook de este repositorio se debe conectar con Jenkins, poniendo su url. 

## Paso 7: Monitoreo con Stackdriver

- Se realiza la instalación de Stackdriver, la cual es la herramienta de monitoreo de Google Cloud Platform

![](Imagenes/instalacionmonitoreo.png)


- A continuación se muestra el monitoreo con Stackdriver, la cual es la herramienta de monitoreo de Google Cloud Platform.

![](Imagenes/monitoreo.png)



### Bibliografía 

- https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/getting_started  (Terraform) 
- https://docs.ansible.com/ansible/latest/index.html (Ansible)
- https://www.jenkins.io/doc/ (Jenkins)
- https://docs.docker.com/get-started/ (Docker)
- https://cloud.google.com/monitoring?hl=es (Monitoreo de Google Cloud Platform) 





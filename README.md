<d align="center">
  <h1><strong>Prototype Django MySQL</strong></h1>
</d>

## ⚙️ Installation

Clone the repository.

```bash
git clone git@github.com:tyronejosee/prototype_django_mysql.git
```

Create a virtual environment (Optional, only if you have Python installed).

```bash
python -m venv env
```

Activate the virtual environment (Optional, only if you have Python installed).

```bash
env\Scripts\activate
```

> Notes: `(env)` will appear in your terminal input.

Install all dependencies (Optional, only if you have Python installed).

```bash
pip install -r requirements/local.txt
```

Create a copy of the `.env.example` file and rename it to `.env`.

```bash
cp .env.example .env
```

**Update the values of the environment variables (Important).**

> Note: Make sure to correctly configure your variables before building the container.

## Local Development with Docker Compose

To set up your local development environment using Docker Compose, follow these steps:

1.  **Copy the environment file:**
    If you haven't already, copy the example environment file to a new `.env` file:
    ```bash
    cp .env.example .env
    ```

2.  **Configure your environment variables:**
    Open the `.env` file and fill in the required environment variables. Pay special attention to the MySQL variables:
    *   `MYSQL_ROOT_PASSWORD`: Set a strong password for the root user of the MySQL database.
    *   `MYSQL_DATABASE`: Specify the name of the database to be created.
    *   `MYSQL_USER`: Define a username for the application to connect to the database.
    *   `MYSQL_PASSWORD`: Set a password for the application user.
    *   `MYSQL_HOST`: This should be set to `db`. This is the service name defined in `docker-compose.yml` and will be used by the `web` service to connect to the database container.
    *   `MYSQL_PORT`: This should be `3306`, which is the default MySQL port.

3.  **Start the services:**
    Once your `.env` file is configured, you can start all the services (including the web application and the database) using the following command:
    ```bash
    docker-compose up --build
    ```
    The `--build` flag ensures that Docker rebuilds your images if there have been any changes to your `Dockerfile` or application code. The first time you run this, it might take a few minutes as Docker downloads the necessary images.

## 🐳 Docker

Build your container; it will take time the first time, as Docker needs to download all dependencies and build the image.
Use the `-d` (detached mode) flag to start your containers in the background.
Use the `--build` flag if you have changes and need to rebuild.

```bash
docker compose up
docker compose up -d
docker compose up --build
```

Stop the running containers (does not remove them).

```bash
docker compose stop
```

Start previously created and stopped containers.

```bash
docker compose start
```

Show container logs in real-time.

```bash
docker compose logs -f
```

Restart a service with issues (Replace `<service_name>`).

```bash
docker compose restart <service_name>
```

Remove your container.

```bash
docker compose down
```

## 🐍 Django

Access the `web` service console that runs Django.

```bash
docker compose exec web bash
```

Inside the Django console, create the migrations.

```bash
python manage.py makemigrations
```

Run the migrations.

```bash
python manage.py migrate
```

If you need to be more specific, use:

```bash
python manage.py migrate <app_label> <migration_name>
```

List all available migrations and their status.

```bash
python manage.py showmigrations
```

> Note: Manually create the migration if Django skips an app; this happens because Django did not find the `/migrations` folder.

Create a superuser to access the entire site without restrictions.

```bash
python manage.py createsuperuser
```

Log in to `admin`:

```bash
http://127.0.0.1:8000/admin/
```

Access Swagger or Redoc.

```bash
http://127.0.0.1:8000/api/schema/swagger/
http://127.0.0.1:8000/api/schema/redoc/
```

## 🚨 Important Notes

Check the creation of migrations before creating them.

```bash
docker compose exec web python manage.py makemigrations users
```

> Note: Checking migrations before their creation is necessary to avoid inconsistencies in user models.

## 🐘 PostgreSQL

Access the PostgreSQL console.

```bash
docker compose exec db psql -U postgres -d example_db
```

List all the tables in the database.

```bash
\dt
```

Show the detailed structure of a specific table.

```bash
\d <table_name>
```

Create a backup of your database (Optional).

```bash
docker compose exec web python manage.py dumpdata > backup.json
```

Load the created backup if needed (Optional).

```bash
docker compose exec web python manage.py loaddata
```

## ⚖️ License

This project is under the [Apache-2.0 license](https://github.com/tyronejosee/prototype_django_mysql/blob/main/LICENSE).

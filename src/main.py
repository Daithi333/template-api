from uvicorn import Server, Config as UvicornConfig

from config import Config
from logs import setup_logging
from app import app

if __name__ == "__main__":
    config = UvicornConfig(
        app=app, port=Config.SERVER_PORT, host=Config.SERVER_HOST
    )
    server = Server(config)
    setup_logging()
    server.run()

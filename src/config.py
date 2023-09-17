import os


def env(key, default=None):
    return os.getenv(key, default)


class Config:

    SERVER_HOST = env("SERVER_HOST", "0.0.0.0")
    SERVER_PORT = int(env("SERVER_PORT", 8080))
    SERVER_CORS_ORIGINS = (
        "*"
        if env("SERVER_CORS_ORIGINS") in ["*", None]
        else env("SERVER_CORS_ORIGINS").split(";")
    )

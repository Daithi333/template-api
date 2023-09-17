from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from config import Config

app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=Config.SERVER_CORS_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
@app.get("/health_check")
async def root():
    return "ok"

"""
Home Assistant Ingress Middleware for FastAPI
This middleware handles the X-Ingress-Path header to make FastAPI apps work with HA ingress.
"""
import os
from fastapi import Request
from starlette.middleware.base import BaseHTTPMiddleware
from starlette.responses import Response
from starlette.types import ASGIApp


class HomeAssistantIngressMiddleware(BaseHTTPMiddleware):
    """Middleware to handle Home Assistant ingress path rewriting."""
    
    def __init__(self, app: ASGIApp):
        super().__init__(app)
        self.ingress_path = os.getenv("INGRESS_PATH", "")
        # Get CORS settings from environment (set by addon config)
        self.cors_origins = os.getenv("CORS_ORIGINS", "*")
        self.cors_methods = os.getenv("CORS_METHODS", "GET, POST, PUT, DELETE, OPTIONS")
        self.cors_headers = os.getenv("CORS_HEADERS", "*")
        
    async def dispatch(self, request: Request, call_next):
        # Get the ingress path from headers or environment
        ingress_path = request.headers.get("X-Ingress-Path", self.ingress_path)
        
        if ingress_path:
            # Store ingress path for use in the application
            request.state.ingress_path = ingress_path
            
            # Modify the request path to remove the ingress prefix
            if request.url.path.startswith(ingress_path):
                # Create new scope with modified path
                scope = dict(request.scope)
                scope["path"] = request.url.path[len(ingress_path):]
                if scope["path"] == "":
                    scope["path"] = "/"
                request._scope = scope
        
        response = await call_next(request)
        
        # Add CORS headers for ingress compatibility using addon config
        if ingress_path:
            response.headers["Access-Control-Allow-Origin"] = self.cors_origins
            response.headers["Access-Control-Allow-Methods"] = self.cors_methods
            response.headers["Access-Control-Allow-Headers"] = self.cors_headers
            
        return response


def setup_ingress_middleware(app):
    """Add ingress middleware to FastAPI app."""
    app.add_middleware(HomeAssistantIngressMiddleware)
    return app

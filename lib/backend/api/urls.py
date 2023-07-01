from django.urls import path, include
from rest_framework import routers
from api.views import AccountView
router = routers.SimpleRouter()
router.register(r'users', AccountView)
urlpatterns = []
urlpatterns += router.urls


from rest_framework.response import Response
import json
from rest_framework import viewsets
from api.models import Account
from api.serializers import AccountSerializer
from django.contrib.auth import get_user_model
from rest_framework.authtoken.models import Token
from rest_framework.decorators import api_view


# Create your views here.
class AccountView(viewsets.ModelViewSet):
    User = get_user_model()
    serializer_class = AccountSerializer
    queryset = Account.objects.all()

    @api_view(['POST'])
    def get_user_info(request):
        data = json.loads(request.body)
        token = data['token']
        id = Token.objects.get(key = token).user_id
        user = Account.objects.get(accountID = id)
        serializer = AccountSerializer(user)
        return Response(serializer.data)

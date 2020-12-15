import MySQLdb as mysql

class BaseORMUtility:

    def __init__(self, *args, **kwargs):
        self.__host = kwargs.get('host')
        self.__port = kwargs.get('port')
        self.__user = kwargs.get('user')
        self.__password = kwargs.get('password')
        self.__db_name = kwargs.get('db_name')

        self._establish_connection()

    def _establish_connection(self):

        self._db = mysql.connect(
            host=self.__host,
            user=self.__user,
            passwd=self.__password,
            db=self.__db_name
        )

        self._cursor = self._db.cursor(mysql.cursors.DictCursor)

    def save_model(model):
        query = model.prepare_save_query() # fetch model-specific save query
        self._cursor.execute(query) # save model
        model.id = _cursor.lastrowid # assign ID to model object instance

import MySQLdb as mysql

host = "159.89.103.55"
port = 3306
user = "zey"
passwd = "Zey.1998"
db_name = "PandemicTracking"

db = mysql.connect(host=host, user=user, passwd=passwd, db=db_name)
_cursor = db.cursor(mysql.cursors.DictCursor)

def save_location(country, city, street, lat, lon):
    query_template = """insert into location (country, city, street, lat, lon) values ('{}', '{}', '{}', {}, {})"""

    _cursor.execute(query_template.format(country,city,street,lat,lon))


def save_camera(location_id):
    query_template = """insert into camera (location_id) values ({})"""

    _cursor.execute(query_template.format(location_id))


def save_scene(location_id, camera_id, live, path):
    query_template = """insert into scene_image (location_id, camera_id, is_live, image_path) values ({}, {}, {}, '{}')"""

    _cursor.execute(query_template.format(location_id, camera_id, live, path))



def save_face(scene_id, location_id, live, path, mask):
    query_template = """insert into face_image (scene_id, location_id, is_live, image_path, mask) values ({}, {}, {}, '{}', {})"""

    _cursor.execute(query_template.format(scene_id, location_id, live, path, mask))


if __name__ == "__main__":
    country = 'Turkey'
    city = 'Ankara'
    street = 'Batıkent'
    lat = -90
    lon = -99 #make lon field in teh table 3 decimals to store up to 180

    save_location(country, city, street, lat, lon)

    location_id = 1

    save_camera(location_id)

    camera_id = 2
    live = 0
    path = "testpath3"

    save_scene(location_id, camera_id, live, path)

    scene_id = 3
    path = "imagepath"
    mask = 0

    save_face(scene_id, location_id, live, path, mask)

    db.commit()
__all__ = [Location, Camera, Scene, Face] # export these upon `import *` call


class Location:

    def __init__(self, *args, **kwargs):
        self.country = kwargs.get('country')
        self.city = kwargs.get('city')
        self.street = kwargs.get('street')
        self.lat = kwargs.get('lat')
        self.lon = kwargs.get('lon')

    def prepare_save_query(self):
        query_template = """insert into location (country, city, street, lat, lon) values ('{}', '{}', '{}', {}, {})"""
        return query_template.format(self.country,self.city,self.street,self.lat,self.lon)


class Camera:

    def __init__(self, *args, **kwargs):
        self.location_id = kwargs.get('location_id')

    def prepare_save_query(self):
        query_template = """insert into camera (location_id) values ({})"""
        return query_template.format(self.location_id)


class Scene:

    def __init__(self, *args, **kwargs):
        self.location_id = kwargs.get('location_id')
        self.camera_id = kwargs.get('camera_id')
        self.live = kwargs.get('live')
        self.path = kwargs.get('path')

    def prepare_save_query(self):
        query_template = """insert into scene_image (location_id, camera_id, is_live, image_path) values ({}, {}, {}, '{}')"""

        return query_template.format(
            self.location_id,
            self.camera_id,
            self.live,
            self.path
        )


class Face:

    def __init__(self, *args, **kwargs):
        self.scene_id = kwargs.get('scene_id')
        self.location_id = kwargs.get('location_id')
        self.live = kwargs.get('live')
        self.path = kwargs.get('path')
        self.mask = kwargs.get('mask')

    def prepare_save_query(self):
        query_template = """insert into face_image (scene_id, location_id, is_live, image_path, mask) values ({}, {}, {}, '{}', {})"""

        return query_template.format(
            self.scene_id,
            self.location_id,
            self.live,
            self.path,
            self.mask
        )

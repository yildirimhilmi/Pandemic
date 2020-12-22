from .orm import BaseORMUtility
from .models import *


def _boot_db_connection():
    orm = BaseORMUtility(
        host = "159.89.103.55",
        port = 3306,
        user = "zey",
        password = "Zey.1998",
        db_name = "PandemicTracking",
    )
    return orm


if __name__ == "__main__":

    orm = _boot_db_connection()

    # --- [1/4] test code to save location ---
    location = Location(
        country='Turkey',
        city='Ankara',
        street = 'Batıkent',
        lat = -90,
        lon = -99
    )
    orm.save_model(location)
    # --- [1/4] ends -------------------------

    # --- [2/4] test code to save camera ---
    camera = Camera(location_id=location.id)
    orm.save_model(camera)
    # --- [2/4] ends -----------------------

    # --- [3/4] test code to save scene ---
    scene = Scene(
        location_id=location.id,
        camera_id=camera.id,
        live=0,
        path="testpath0"
    )
    orm.save_model(scene)
    # --- [3/4] ends ----------------------

    # --- [4/4] test code to save face ----
    face = Face(
        scene_id=scene.id,
        path="some_image_path_comes_here",
        mask=0
    )
    orm.save_model(face)
    # --- [4/4] ends ----------------------

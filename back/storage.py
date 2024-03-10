import datetime

from decouple import config
from fastapi import UploadFile
from firebase_admin import credentials, storage, initialize_app

cred = credentials.Certificate('firebase-key.json')
initialize_app(cred, {
    'storageBucket': config('FIREBASE_STORAGE_BUCKET')
})

bucket = storage.bucket()


def upload_profile_picture(file: UploadFile):
    blob = bucket.blob(file.filename)
    blob.upload_from_file(file.file, content_type=file.content_type)

    file_url = blob.generate_signed_url(datetime.datetime.strptime('2100-01-01', '%Y-%m-%d'))
    filename = file.filename

    return file_url, filename


def get_file_url(filename):
    blob = bucket.blob(filename)
    return blob.generate_signed_url(datetime.datetime.strptime('2100-01-01', '%Y-%m-%d'))
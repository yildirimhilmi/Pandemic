import glob
import os
import cv2
import time
import face_detection
import mmcv, cv2
from cv2 import dnn_superres
from PIL import Image, ImageDraw


def draw_faces(im, bboxes):
    for bbox in bboxes:
        x0, y0, x1, y1 = [int(_) for _ in bbox]
        cv2.rectangle(im, (x0, y0), (x1, y1), (0, 0, 255), 2)

def extract_faces(im, bboxes,impath,i):
    #sr = dnn_superres.DnnSuperResImpl_create()
    #pathRes = "EDSR_x3.pb"
    #sr.readModel(pathRes)
    #sr.setModel("edsr", 5)
    index =1
    for bbox in bboxes:
        x0, y0, x1, y1 = [int(_) for _ in bbox]
        h0= int((y0+y1)/2) # can be used to divide
        face_im=im[y0:y1,x0:x1]
        imname = os.path.basename(impath).split(".")[0]
        path = "faces/"+"framev4_"+str(i)+"_"+str(index)+".jpg"
        x,y = x1-x0,y1-y0
        #result = sr.upsample(face_im)
        cv2.imwrite(path,face_im)
        index+=1

if __name__ == "__main__":
    try:

        impaths = "images"
        impaths = glob.glob(os.path.join(impaths, "*.jpg"))
        detector = face_detection.build_detector(
            "DSFDDetector",
            confidence_threshold=0.7,
            max_resolution=5000
        )
        path_data = "video_input/"
        video_name1 = "v4.mp4"
        video_name= path_data+video_name1

        video = mmcv.VideoReader(video_name)
        frames = [frame for frame in video]
        frames = frames[::140]
        #print(len(frames))
        #print("---------------------")
        i=0
        for im in frames:
            #if impath.endswith("out.jpg"): continue
            #im = cv2.imread(impath)

            #print("Processing:", impath)

            t = time.time()
            #print("inside")
            dets = detector.detect(
                im[:, :, ::-1]
            )[:, :4]
            print(f"Detection time: {time.time()- t:.3f}")
            extract_faces(im,dets,'faces',i)
            #draw_faces(im, dets)
            #print("inside here")
            #extract_faces(im,dets,'faces')
            """ imname = os.path.basename(impath).split(".")[0]
            output_path = os.path.join(
                os.path.dirname(impath),
                f"{imname}_out.jpg"
            ) """
            i+=1

            #cv2.imwrite(output_path, im)
    except Exception as e:
        print(e)
        
        
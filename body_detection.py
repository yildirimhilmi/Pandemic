#!/usr/bin/env python
# coding: utf-8

# In[18]:


import cv2
import imutils
import numpy as np


# In[19]:


def detect(frame):
    box_coor, weights =  HOGCV.detectMultiScale(frame, winStride = (4, 4), padding = (8, 8), scale = 1.03)
    body = 0
    for i, (x,y,w,h) in enumerate(box_coor):
        if weights[i] < 0.8:  #threshold,, we can determine something different later
            continue
        body += 1
        x=x+25
        y=y+20
        image=cv2.rectangle(frame, (x,y), (x+20,y+20), (255,0,0), 2) #detect heads(drawing rectangle around)
        image=cv2.rectangle(frame, (x,y), (x+w,y+h), (255,0,0), 2) #detect bodies (drawing rectangle around)
        crop_img = image[y:y+30, x:x+30] #cropping heads ( but not working properly we can change)
        #cv2.imshow("cropped", crop_img)
        cv2.waitKey(0)
        cv2.putText(frame, f'body {body}', (x,y), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,0,255), 1)
        
    cv2.putText(frame, f'Total body : {body}', (40,70), cv2.FONT_HERSHEY_DUPLEX, 0.8, (255,0,0), 2)
    return frame


# In[20]:


def bodyDetector(camera,image, video):
    image_path = "./face_detect"
    writer = None
    if image:
        print('opening the image')
        detectImage("./face_detect/istiklal2.jpg")
''' elif camera:
        #writer eklenecek
        detectByCam(path,writer)
    
    elif video:
        #writer eklenecek
        #func eklenecek
        detectByVideo(path, writer) '''


# In[21]:


def detectImage(path):
    image = cv2.imread(path)
    image = imutils.resize(image, width = min(800, image.shape[1])) 
    result_image = detect(image)
    cv2.imshow("results", result_image)
    cv2.imwrite("results.jpg", result_image)
    cv2.waitKey(0)
    cv2.destroyAllWindows()
    
def detectByCam(writer):
    video = cv2.VideoCapture(0)
    while True:
        check, frame = video.read()
        frame = detect(frame)
        if writer is not None:
            writer.write(frame)
        key = cv2.waitKey(1)
        if key == ord('q'):
                break
    video.release()
    cv2.destroyAllWindows()


# In[22]:


HOGCV = cv2.HOGDescriptor()
HOGCV.setSVMDetector(cv2.HOGDescriptor_getDefaultPeopleDetector())
bodyDetector(False,True,False)


# In[ ]:





#!/usr/bin/env python
# coding: utf-8

# # Convolutional Neural Network

# ### Importing the libraries

# In[1]:


import tensorflow as tf
import cv2
from keras.preprocessing.image import ImageDataGenerator


# In[2]:


tf.__version__


# ## Part 1 - Data Preprocessing

# ### Preprocessing the Training set

# In[3]:


train_datagen = ImageDataGenerator(rescale=1./255,
                    rotation_range=45,
                    width_shift_range=.15,
                    height_shift_range=.15,
                    horizontal_flip=True)

training_set = train_datagen.flow_from_directory('dataset\data_train_resized_fena_olmayan3',
                                                 target_size = (224, 224),
                                                 #color_mode="rgh",
                                                 batch_size = 32,
                                                 class_mode = 'binary')


# ### Preprocessing the Test set

# In[4]:


test_datagen = ImageDataGenerator(rescale = 1./255)
test_set = test_datagen.flow_from_directory('dataset\datatest3graycropwithout',
                                            target_size = (224, 224),
                                            #color_mode="grayscale",
                                            batch_size = 32,
                                            class_mode = 'binary')


# ## Part 2 - Building the CNN

# ### Initialising the CNN

# In[5]:


cnn = tf.keras.models.Sequential()


# ### Step 1 - Convolution

# In[6]:


cnn.add(tf.keras.layers.Conv2D(filters=64, kernel_size=7, activation='relu', input_shape=[224, 224, 3]))


# ### Step 2 - Pooling

# In[7]:


cnn.add(tf.keras.layers.MaxPool2D(pool_size=2, strides=2))


# ### Adding a second convolutional layer

# In[8]:


cnn.add(tf.keras.layers.Conv2D(filters=32, kernel_size=5, activation='relu'))
cnn.add(tf.keras.layers.MaxPool2D(pool_size=2, strides=2))


# ### Step 3 - Flattening

# In[9]:


from keras.layers import Dropout
cnn.add(tf.keras.layers.Flatten())


# ### Step 4 - Full Connection

# In[10]:


cnn.add(tf.keras.layers.Dense(units=200, activation='relu'))
cnn.add(tf.keras.layers.Dense(units=100, activation='relu'))


# ### Step 5 - Output Layer

# In[11]:


cnn.add(tf.keras.layers.Dense(units=1, activation='sigmoid'))

cnn.summary()


# ## Part 3 - Training the CNN

# ### Compiling the CNN

# In[12]:


cnn.compile(optimizer = 'adam', loss = 'binary_crossentropy', metrics = ['accuracy'])


# ### Training the CNN on the Training set and evaluating it on the Test set

# In[13]:


cnn.fit(x = training_set, validation_data = test_set, epochs = 20)


# In[18]:


cnn.save("saved_model/cnn_mask_model_croppedfaces.h5", save_format="h5")


# ## Part 4 - Making a single prediction

# In[20]:


import numpy as np
import glob
import os
import time
from keras.preprocessing import image
from tensorflow import keras
import cv2

cnn=keras.models.load_model("saved_model/cnn_mask_model_croppedfaces.h5")


'''#deneyecegimiz imageları cnn'imizin kullandigi formata ceviriyoruz
#boyutu ayarladik
test_image = image.load_img("dataset/single_prediction/('bursa_osmangazi_metro_2', 1)_face.jpg", target_size = (224, 224))
#test_image'i numpy array'e ceviriyoruz predict methodu np arrayi istedigi icin
test_image = image.img_to_array(test_image)
#ekstra dimension ekliyoruz??
test_image = np.expand_dims(test_image, axis = 0)
#result 2d array olarak donuyor
result = cnn.predict(test_image)
print(training_set.class_indices)'''


impaths = "dataset/zsingle_prediction"
outpath_masked="dataset/zsingle_prediction/masked/masked"
outpath_nomasked="dataset/zsingle_prediction/no_masked/no_masked"
impaths = glob.glob(os.path.join(impaths, "*.jpg"))
total_im=0
total_time=0
total_masked=0
total_withoutmask=0
for impath in impaths:
        print("Processing:", impath)
        total_im+=1
        t = time.time()
        
        res = cv2.imread(impath)
        test_image = image.load_img(impath, target_size = (224, 224),color_mode="grayscale")
        test_image = image.img_to_array(test_image)
        test_image = np.expand_dims(test_image, axis = 0)
        result = cnn.predict(test_image)
        print(f"Detection time: {time.time()- t:.3f}")
        total_time+=time.time()-t
        if 1-result[0][0]>result[0][0]:
            print("masked: ",1-result[0][0])
            imname = os.path.basename(impath).split(".")[0]
            output_path = os.path.join(
            os.path.dirname(outpath_masked),
            f"{imname}_out.jpg"
            )
            cv2.imwrite(output_path, res)
            total_masked+=1
        
        else:
            print("no_masked: ",result[0][0])
            imname = os.path.basename(impath).split(".")[0]
            output_path = os.path.join(
            os.path.dirname(outpath_nomasked),
            f"{imname}_out.jpg"
        )
            cv2.imwrite(output_path, res)
            total_withoutmask+=1
        
print("total time: ",total_time)
print("total image: ",total_im)
print("total masked: ",total_masked, " total without mask: ", total_withoutmask)


# In[ ]:





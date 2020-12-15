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

training_set = train_datagen.flow_from_directory('dataset\data_train',
                                                 target_size = (224, 224),
                                                 #color_mode="rgh",
                                                 batch_size = 32,
                                                 class_mode = 'binary')


# ### Preprocessing the Test set

# In[4]:


test_datagen = ImageDataGenerator(rescale = 1./255)
test_set = test_datagen.flow_from_directory('dataset\datatest',
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


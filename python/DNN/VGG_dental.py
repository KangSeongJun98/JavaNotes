from keras import Sequential
from keras.layers import Flatten, Dense, Dropout
from keras.applications import VGG16
from keras.preprocessing.image import ImageDataGenerator
train_dir = './dental_image/train'
test_dir = './dental_image/test'
# 이미지 증강 (학습 데이터가 너무 적을 때)
train_gen = ImageDataGenerator(
    rotation_range=180          #180도 회전
   ,width_shift_range=0.2       #좌우 이동
   ,height_shift_range=0.2      #상하 이동
   ,horizontal_flip=True        #좌우 반전
   ,vertical_flip=True          #상하 반전
   ,brightness_range=[0.5, 1.5] #명암 증강
)
test_gen = ImageDataGenerator()
train_generator = train_gen.flow_from_directory(train_dir
                                                ,target_size=(224,224), batch_size=32
                                                ,class_mode='categorical', shuffle=True)
test_generator = train_gen.flow_from_directory(test_dir
                                                ,target_size=(224,224), batch_size=32
                                                ,class_mode='categorical', shuffle=True)
# 분류 클래스 수
class_num = len(train_generator.class_indices)
# 클래스의 명칭
labels = list(train_generator.class_indices.keys())
# vgg16은 1000개의 클래스로 pre-training 되어진 모델(사전 학습된)
# 사전 학습된 모델을 새로운 목적으로 변경하는 것을 fine-tuning 이라고 함
vgg_layer = VGG16(weights='imagenet'
                  ,include_top=False, input_shape=(224,224,3))
vgg_layer.summary()
for layer in vgg_layer.layers:
    layer.trainable = False # 잘 학습 되어진 부분은 학습되지 않도록 고정

# 새로운 모델 생성
model = Sequential()
model.add(vgg_layer) # pre-training 되어진 layer 추가
model.add(Flatten())
model.add(Dense(1024, activation='relu'))
model.add(Dropout(0.5))
model.add(Dense(class_num, activation='softmax'))
model.summary()
model.compile(loss= 'categorical_crossentropy', optimizer='adam'
              , metrics=['acc'])
model.fit_generator(train_generator
                    ,steps_per_epoch=train_generator.samples/ train_generator.batch_size
                    ,epochs=50
                    ,validation_data=test_generator
                    ,validation_steps=test_generator.samples/ test_generator.batch_size
                    , verbose=1)
model.save('dental_model.h5')
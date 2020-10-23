#Реализовать все шаги

dvc run -n base_part \
        -d ../services/base_part.py \
        -o ../data/base_part.fthr \
        python -u ../services/base_part.py
        
dvc run -n feature1 \
	-d ../services/feature1.py \
        -o ../data/feature1.fthr \
        python -u ../services/feature1.py
	
dvc run -n feature2 \
	-d ../services/feature2.py \
        -o ../data/feature2.fthr \
        python -u ../services/feature2.py
	
dvc run -n model \
	-d ../data/base_part.fthr \
	-d ../data/feature1.fthr \
	-d ../data/feature2.fthr \
	-o ../data/model.pickle \
	python -u ../services/model.py

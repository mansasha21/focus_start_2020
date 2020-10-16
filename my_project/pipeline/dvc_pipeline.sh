#Реализовать все шаги

dvc run -n base_part \
        -d ../services/base_part.py \
        -o ../data/base_part.fthr \
        python -u ../services/base_part.py
        
dvc run -n feature_name_1 \
	...
	
dvc run -n feature_name_2 \
	...
	
dvc run -n model.dvc \
	...

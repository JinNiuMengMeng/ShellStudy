#!/bin/sh

# 示例一(遍历)
for ONE in apple banana pear orange; do
	echo "I like $ONE!"
done

# 批量重命名(将one1 one2 one3 重命名为one1~ one2~ one3~)
# for FILE in one?; do 
# 	mv $FILE $FILE$FILE
# done
# 或者
for FILENAME in `ls one?`; do
	mv $FILENAME $FILENAME$FILENAME
done
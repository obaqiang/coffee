# 记住几个正则案例，提升处理正则表达式的能力
1. task： 匹配前面三个，但是不匹配最后一个
Match	cat.	
Match	896.	
Match	?=+.
Skip	abc1

solution : ...\.
> 匹配前面三个任意字符，并且不匹配最后一个, 注意这里的\是作为转义字符处理.

2. Task		 
Match	can	
Match	man	
Match	fan	
Skip	dan	
Skip	ran	
Skip	pan

solution: [cmf]an
> 使用中括号[]处理某一个目标字符

3. Task	Text 
Match	hog	
Match	dog	
Skip	bog

solution ：[^b]og 
> 中括号中使用^ 表示去除匹配某个条件


4. Task	 
Match	Ana	
Match	Bob	
Match	Cpc	
Skip	aax	
Skip	bby	
Skip	ccz

solution:[A-C][n-p][a-c]
> 匹配带范围的字母

5. Task		 
Match	wazzzzzup	
Match	wazzzup	
Skip	wazup

solution：waz{3,5}up
> 使用中括号处理匹配的次数

6. Task	Text	 
Match	1 file found?	
Match	2 files found?	
Match	24 files found?	
Skip	No files found.

solution: \d+ files? found\?
> 使用?作为可选，注意匹配？时要加\转义字符

7. Task	Text	 
Match	Mission: successful	
Skip	Last Mission: unsuccessful	
Skip	Next Mission: successful 

solution: ^Mission: successful$
> ^匹配开头 $匹配结尾

8. Task	Text	Capture Groups	 
Capture	file_record_transcript.pdf	file_record_transcript	
Capture	file_07241999.pdf	file_07241999	
Skip	testfile_fake.pdf.tmp

solution: ^(file.+)\.pdf$
> 使用（和）捕获组信息， （）包裹的即是目标内容

9. Task	Text	Capture Groups	 
Capture	Jan 1987	Jan 1987 1987	
Capture	May 1969	May 1969 1969	
Capture	Aug 2011

solution: ([A-Za-z]* (\d+))
> 嵌套的（） 可以匹配多个内容

10. Task	Text	 
Match	I love cats	
Match	I love dogs	
Skip	I love logs	
Skip	I love cogs

solution:I love (cats|dogs)
> 使用|匹配不同条件
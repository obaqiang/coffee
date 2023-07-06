# javascript 正则表达式的使用
正则表达式（Regular Expression）是一种强大的文本模式匹配工具，可以用于在字符串中查找、替换和提取特定的文本。下面是一些常见的正则表达式实例及其使用方法

1. exec 方法
exec 方法用于在字符串中执行正则表达式的匹配，并返回匹配结果的详细信息。它返回一个数组，包含匹配到的字符串及其捕获组的信息。如果未找到匹配项，则返回 null。
``` js
const regex = /([A-Za-z]* (\d+))/;
const str = "Jan 1987";
const result = regex.exec(str);
console.log(result); // ["Jan 1987", "Jan 1987", "1987"]

```
在上面的例子中，通过 exec 方法匹配了字符串 "Jan 1987"，并提取了月份和年份的信息。

2. test 方法
test 方法用于测试正则表达式在给定字符串中是否有匹配项。它返回一个布尔值，表示是否存在匹配项。
``` js
const regex = /^Mission: successful$/;
const str = "Mission: successful";
const result = regex.test(str);
console.log(result); // true

```
上述代码使用 test 方法检查字符串 "Mission: successful" 是否符合以 "Mission: successful" 开头且以此结尾的模式。

3. match 方法
match 方法用于在字符串中查找与正则表达式匹配的内容，并以数组形式返回所有匹配项。
``` js
const regex = /\d+ files? found\?/;
const str = "2 files found?";
const result = str.match(regex);
console.log(result); // ["2 files found?"]

```
在上面的例子中，使用 match 方法查找字符串 "2 files found?" 中符合正则表达式 \d+ files? found\? 的内容。

4. matchAll 方法
matchAll 方法用于在字符串中查找所有与正则表达式匹配的内容，并返回一个迭代器对象。每个迭代器包含匹配项及其捕获组的信息。
``` js
const regex = /([A-C][n-p][a-c])/g;
const str = "Ana Bob Cpc";
const matches = [...str.matchAll(regex)];
console.log(matches);
// [
//   ["Ana", "Ana"],
//   ["Bob", "Bob"],
//   ["Cpc", "Cpc"]
// ]

```
上述代码使用 matchAll 方法查找字符串 "Ana Bob Cpc" 中符合正则表达式 ([A-C][n-p][a-c]) 的所有内容。

5. search 方法
search 方法用于在字符串中搜索与正则表达式匹配的第一个位置，并返回匹配的索引。如果未找到匹配项，则返回 -1。
``` js
const regex = /waz{3,5}up/;
const str = "wazzzup";
const result = str.search(regex);
console.log(result); // 0

```
上述代码使用 replace 方法，将字符串 "2 files found?" 中匹配到的内容替换为 "Found 2 files"。

6. replace 方法
replace 方法用于将字符串中与正则表达式匹配的内容替换为指定的值。
``` js
const regex = /(\d+) files? found\?/;
const str = "2 files found?";
const result = str.replace(regex, "Found $1 files");
console.log(result); // "Found 2 files"

```
上述代码使用 replace 方法，将字符串 "2 files found?" 中匹配到的内容替换为 "Found 2 files"。

7. split 方法
split 方法用于根据正则表达式将字符串拆分成数组。
``` js
const regex = /\s+/;
const str = "I love cats";
const result = str.split(regex);
console.log(result); // ["I", "love", "cats"]

```

上述代码使用 split 方法，根据正则表达式 \s+（匹配一个或多个空格）将字符串 "I love cats" 拆分成数组。
---
theme: fancy
---
在使用 axios 发起请求时，有两种方法可以取消请求：

> 1. 通过 CancelToken 实例来取消请求
您可以通过创建一个 CancelToken 实例并将其传递给请求的 config 对象中来实现取消请求。然后，在需要取消请求的地方，您可以调用 cancel 方法以发送取消请求信号。

以下是一个例子：
``` js
import axios from 'axios';

const source = axios.CancelToken.source();

const fetchData = async () => {
  try {
    const res = await axios.get('/some/url', { cancelToken: source.token });
    console.log(res.data);
  } catch (error) {
    if (axios.isCancel(error)) {
      console.log('Request canceled:', error.message);
    } else {
      console.log(error);
    }
  }
};


// 在某个时刻取消请求
source.cancel('Operation canceled by the user.');
```



在上面的代码中，我们首先创建了一个名为 source 的 CancelToken 实例，并将其传递给请求的 config 对象中。然后，在需要取消请求的位置，我们通过调用 source.cancel() 方法来发送取消请求信号。如果请求已经被取消，则会抛出一个包含取消原因的错误，并且您可以在 catch 块中检查这个错误并处理它。

> 2. 通过 cancel 属性来取消请求
另一种方法是直接在请求对象上设置 cancel 属性，该属性是一个函数。当您需要取消请求时，只需调用此函数即可。

以下是一个例子：
``` js
import axios from 'axios';

const fetchData = async () => {
  const request = axios.get('/some/url');

  // 在某个时刻取消请求
  request.cancel('Operation canceled by the user.');

  try {
    const res = await request;
    console.log(res.data);
  } catch (error) {
    if (axios.isCancel(error)) {
      console.log('Request canceled:', error.message);
    } else {
      console.log(error);
    }
  }
};
```

在上面的代码中，我们首先发起一个请求，并将其分配给一个变量 request。然后，在需要取消请求的位置，我们通过调用 request.cancel() 方法来发送取消请求信号。如果请求已经被取消，则会抛出一个包含取消原因的错误，并且您可以在 catch 块中检查这个错误并处理它。

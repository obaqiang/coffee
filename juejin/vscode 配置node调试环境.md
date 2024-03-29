
> VS Code 是一款非常流行的代码编辑器，主要用于开发各种编程语言的应用程序。对于使用 Node.js 进行开发的开发人员来说，VS Code 提供了内置的调试功能，可以轻松地配置和调试 Node.js 应用程序。

在本文中，我们将介绍如何在 VS Code 中配置和使用 Node.js 调试环境。我们将从功能的介绍开始，并提供逐步案例教学，以帮助初学者了解如何使用这些功能。

# 功能介绍

VS Code 的 Node.js 调试功能具有以下特点：

内置支持：VS Code 的内置 Node.js 扩展可让您轻松配置和调试 Node.js 应用程序，而无需安装其他插件或扩展。
高级断点：您可以在代码中设置断点，以便在运行过程中暂停代码执行并检查变量值。
控制台输出：您可以在控制台中查看程序输出和错误信息，并与 Node.js 应用程序进行交互。
启动配置：您可以通过启动配置指定应用程序的入口文件、参数和环境变量等信息。
以上功能使得 VS Code 成为一个强大的 Node.js 开发工具。

# 案例教学

接下来，我们将提供一个详细的案例教学来演示如何在 VS Code 中配置和使用 Node.js 调试环境。

## 步骤一：安装 VS Code

首先，您需要下载和安装 VS Code。您可以从官方网站上下载最新版本的 VS Code，并按照提示进行安装。

## 步骤二：创建一个 Node.js 应用程序

接下来，我们将创建一个简单的 Node.js 应用程序。在您选择的位置创建一个新文件夹，然后在该文件夹中创建一个名为 app.js 的文件。

在 app.js 文件中输入以下代码：

```javascript

function add(a, b) {
  return a + b;
}

console.log(add(1, 2));
```

该代码定义了一个名为 add 的函数，并在控制台中输出 add(1, 2) 的结果。这将是我们要调试的应用程序。

## 步骤三：配置启动配置

现在，让我们配置启动配置。在 VS Code 中，点击左侧菜单栏中的“调试”按钮，然后点击“创建启动配置”按钮。这将打开一个 .vscode/launch.json 文件，其中包含启动配置信息。

在该文件中添加以下内容：

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "node",
      "request": "launch",
      "name": "Debug Node.js file",
      "program": "${workspaceFolder}/app.js",
      "console": "integratedTerminal",
      "internalConsoleOptions": "neverOpen"
    }
  ]
}
```

以上设置指定了启动配置的类型、请求（调试）、名称和程序入口文件。还指定了将在集成终端中打开控制台，并且永远不会自动打开内部控制台。

## 步骤四：设置断点

接下来，我们将设置一个断点以便暂停程序执行并检查变量值。在 add 函数的第一行添加一个断点，在 VS Code 的编辑器中使用鼠标右键单击该行代码并选择“切换断点”即可。

## 步骤五：启动调试

现在，我们已经准备好开始调试 Node.js 应用程序了。在左侧菜单栏中点击“调试”按钮，然后点击“启动调试”按钮。这将启动您的应用程序，并在遇到断点时暂停执行。

## 步骤六

：检查变量值

我们已经设置了断点并启动了调试，现在我们可以检查变量值。当应用程序运行到断点时，VS Code 的调试控制台将显示在代码执行期间定义的所有变量和对象。

在本例中，我们可以看到 a 和 b 变量的值分别为 1 和 2。您还可以使用 VS Code 的调试控制台来输入代码并与 Node.js 应用程序进行交互。

## 步骤七：继续执行

如果您想让代码继续执行，只需单击“继续”按钮即可。此时，应用程序将继续执行，直到遇到下一个断点或完成执行。

## 步骤八：结束调试

当您完成调试时，只需按下“停止”按钮即可关闭应用程序并结束调试会话。

# 结论

通过本文的介绍和案例教学，您现在应该能够在 VS Code 中配置和使用 Node.js 调试环境了。请记住，VS Code 提供了内置的调试功能，以及高级断点、控制台输出和启动配置等强大的功能，可以帮助您更轻松地开发和测试 Node.js 应用程序。

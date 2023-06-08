# 此方案出现的理由
1. 小程序中无法使用vue.directive的指令方法函数实现防抖节流
2. 传统的防抖节流方式相对繁琐

# 实现方案及效果
1. 新建一个debounce-view组件
2. 直接用debounce-view包裹需要防抖的内容即可，如下：
``` 
<debounce-view @thTap="buyNow">
        <view class="buy-now">立即购买</view>
</debounce-view>
```
防抖组件内容：
``` html
//debounce-view
<template>
	<view @click.stop="deTap">
		<slot></slot>
	</view>
</template>

<script>
	function deBounce(fn, delay = 500, immediate) {
		let timer = null,
			immediateTimer = null;

		return function() {
			let args = arguments,
				context = this;

			// 第一次触发
			if (immediate && !immediateTimer) {

				fn.apply(context, args);
				//重置首次触发标识，否则下个周期执行时会受干扰
				immediateTimer = setTimeout(() => {
					immediateTimer = null;
				}, delay);
			}
			// 存在多次执行时，重置动作需放在timer中执行；
			if (immediateTimer) clearTimeout(immediateTimer);
			if (timer) clearTimeout(timer);

			timer = setTimeout(() => {
				fn.apply(context, args);
				timer = null;
				immediateTimer = null;
			}, delay);
		}
	}
	export default {
		methods: {
			deTap: deBounce(function() {
				console.log('deTap')
				this.$emit('deTap')
			}, 500, true),
		}
	}
</script>

<style>
</style>
```
节流组件内容：
``` html
<template>
	<view @click.stop="thTap">
		<slot></slot>
	</view>
</template>

<script>
	// 第二版
	function throttle(func, wait) {
		var timeout;
		var previous = 0;

		return function() {
			context = this;
			args = arguments;
			if (!timeout) {
				timeout = setTimeout(function() {
					timeout = null;
					func.apply(context, args)
				}, wait)
			}

		}
	}
	export default {
		methods: {
			thTap: throttle(function() {
				this.$emit('thTap')
			}, 500)
		}
	}
</script>

<style>
</style>
```

# 总结
1. 上述方法有有点但也有缺点，优点是使用起来非常的快捷方便，缺点是时间目前是写死的，各位看官如果有新的想法或者意见还请指教小弟一二
The skills
``` js
let nums = [73, 74, 75, 71, 71, 72, 76, 73]
function solutions(nums){
    let res = []
    let stack = []
    let len = nums.length
    for(let i=0;i<len;i++){
        while(stack.length&&nums[i]>nums[stack[stack.length-1]]){
            let index = stack.pop()
            res[index] = nums[i]   
        }
        stack.push(i)
    }
    return res
}
```

1. Use a stack to store **nums** subscripts
2. Loop the nums,find the target index to push to **res**
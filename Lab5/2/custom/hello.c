#include <linux/kernel.h>

asmlinkage long sys_hello(void) 
{
        //printk prints to the kernel’s log file.
        printk("Greetings from kernel and team no 6\n");
        return 0;
}

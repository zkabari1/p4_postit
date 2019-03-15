# p4_postit
IOS app using swift with php to post notes

Just like sticky notes, it helps you create a to-do list. 
Code uses tableview to display list of items.Also support multiline cells. 
You can add new post using textbox and + button.
It redirects to php server which gives error if post is empty, otherwise add post to the existing list.
On error an alert prompts, which you need to close to resume your activity.
You can refresh the list by dragging list down and releasing it which reloads tableview in backend.
To delete any post, swipe right to left which shows delete button. Click and selected post gets deleted.

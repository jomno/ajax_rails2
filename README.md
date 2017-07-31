AJAX RAILS 2
=
일반 ajax는 요청과 응답 두 가지를 고려해야 하지만 rails ajax는 :remote 코드의 도움으로<br>
요청 시 jqery ajax 코드를 사용하지 않고 ajax 요청을 쉽게 구현할 수 있습니다.<br>
그렇다면 고민해야 할 부분은 응답입니다. 기본적인 응답 법에 대해 작성하겠습니다.
## 준비 작업
* bash
```bash
rails g controller home index
rails g model comment body
rake db:migrate
```
* config/routes.rb
```ruby
[...]
root 'home#index'
post 'home/create'
get 'home/index'
[...]
```
* app/views/home/index.html.erb
```html
<form action="/home/create" method="post" data-remote="true">
    <label>댓글 작성</label>
    <input type="text" name="body" id="comment_body">
    <input type="submit">
</form>
<div id="body">
    <% @comments.each do |comment| %>
        <hr>
        <%= comment.body%>
    <% end %>
</div>
```
form 부분에 date-remote="true" 메소드를 추가해줘서 ajax 요청 생성
## 응답 코드
* app/controllers/home_controller.rb
```ruby
[...]
def index
    @comments = Comment.all
end
def create
    @comment = Comment.new(body: params[:body])
    if @comment.save
      respond_to do |format|
        format.js #응답을 js로 하겠다.
      end
    end
end
[...]
```
create에서 Comment를 저장하면 respond_to 메소드를 사용해서 응답을 js로 함(format.js)
@comment변수도 넘어감
* app/views/home/create.js.erb
```js
$('#comment_body').val("");
$('#body').append("<hr><%= @comment.body%>");
```
성공적으로 응답을 받으면 create.js.erb로 응답이 가는데 이 후 input의 내용을 지우고<br>
body에다가 아까 저장이 성공한 @comment.body를 추가시킵니다.

완성!!

### Reference post
[rails ajax comment blog post](http://blog.saltfactory.net/using-ajax-and-partial-in-rails/)<br>
[괜찮은 블로그](http://wantknow.tistory.com/71)
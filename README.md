# Choose Your Own Adventure
## By: [Noah](https://github.com/nwimmer123)

#Overview

A user can play and create chose your own adventure stories.

#Screenshot

The Home Page



#Links


#Approach

I mostly used an outside in approach when creating this site. I started off with wireframes and maped out all the connections. Then I created the models, so i could hard code data in. I created the views and routes to view each wireframed page. I did not use scaffold, to reduce the amount of code 'congestion' to make trouble shooting easier. I also wrote very stripped down initial HTML pages to make sure that the data was coming in correctly. Once all the basic connections were working, then I added some basic style to make it easier to look at. Then I started trying to connect the choices with the story together, and that's where the fun really started.

#Future Additions

* Back navigation in story creation mode.
* Complete validation and authorization.
* The End page that displays when a story is over.
* Data visualization so that the user can see the stroy tree build and click on different paths they want to edit and be directed there.

#Bugs

* In story display a choice button isn't always displayed if tthat path was never edited.
* In story create mode the edit path b button doesn't connect correctly to it's route, so I made it its own route, which is just a temporary fix, as it shouldn't require it's own route. Both edit path buttons should be able to use the same route. 



#Take Away

Coding solo is so much harder then working on a team!!!

#Code Samples

I wanted to have a tree, linked list, for the story and choices. This was very hard. The parent choice, contains two children. The ID of each of these children need to be the same as the ID of the parent node. Here, within was the challenge. I needed to hold the value of the prior choice and on moving to the child node save it back into the parent.

When I initially set up my models, I just did 

```
GAME MODEL
  belongs_to :user
  has_many :choices
  
CHOICE MODEL 
 belongs_to :game
```

thinking that would be enough; however, it didn't create a "deep" foreign key. I was able to dig into the data to see which game's were associated with each user and display them, but other things weren't working. Breon and Daniel pointed out I needed to have these associations have actual foreign keys. 

Thanks Breon and Daniel!!

```
CHOICE MODEL
  belongs_to :choice_a, class_name: "Choice", foreign_key: "choice_a_id"
  belongs_to :choice_b, class_name: "Choice", foreign_key: "choice_b_id"

GAME MODEL
	belongs_to :starting_choice, class_name: "Choice", 	foreign_key: "starting_choice_id"
```

I also had to attach the Game model to the first Choice model, which I managed on my own.

```
CHOICE CONTROLLER - 

  def create
	STANDARD CREATE CODE
    @choice.save

    if @game.starting_choice_id == nil 
      @game.starting_choice = @choice
      @game.save
    else
      @choice.save
    end

    redirect_to edit_choice_path(@choice.game_id,@choice) 

  end
```
This first checked to see if the parent node, was alraedy a starter, if not then it assigned the choice id to the starting choice id. That way the game id would be linked with the choices id so that the reader would be able to view the story. I am very proud of these simple little lines of code.

I was hoping that the establishment of the rest of the nodes would be in the same line, so I triel a lot of different things, that were similar, but none worked because I no longer had access to the id in the params bar.

I eventually setteled to placing the parents id in a hidden field on the choice edit page.

```
<% unless @parent.nil? %>
	<%= f.hidden_field :parent_id, :value => @parent.id %>
<% end %>
```

I still couldn't make the parent/child relationship work though and so at the 9th hour, Nathan created it in the choices model, the edit new child view, the routes and the choice controller, after a lot of poking around.


Thanks Nathan!!

Key Componenets of parent/child relationship

```
CHOICE MODEL 
  def children
    children = Choice.where(id: [self.choice_a_id, self.choice_b_id].compact )
    children.empty? ? nil : children.first
  end

  def child_a
    Choice.find_by_id(self.choice_a_id)
  end

  def child_b
    Choice.find_by_id(self.choice_b_id)
  end

```

```
ROUTES
get '/games/:game_id/choices/:id/edit', to: 'choices#edit', as: 'edit_choice' 
patch '/games/:game_id/choices/:choice_id/child/:letter', to: 'choices#create_child', as: 'create_a_child'
```
```
EDIT CHOICE VIEW
<% if @choice.child_a %>
  <%= link_to "Edit Path A", edit_choice_path(@choice.game_id, @choice.child_a), class: "edit btn btn-warning" %>
<% else %>
  <%= button_to "Create Path A", create_a_child_path(@choice.game_id, @choice.id, "a"), formmethod: "post", formaction: create_a_child_path(@choice.game_id, @choice.id, "a"), class: "edit btn btn-warning" %>
<% end %>
```
```
CHOICES CONTROLLER
  def create_child
    @parent_choice = Choice.find(params[:choice_id])
    @child_choice = Choice.create(game_id: params[:game_id])

    if params[:letter] == "a"
      @parent_choice.update!(choice_a_id: @child_choice.id)  
    elsif params[:letter] == "b"
      @parent_choice.update!(choice_b_id: @child_choice.id)  
    end
    
    redirect_to edit_choice_path(@child_choice.game_id, @child_choice.id)
  end
```
Also huge thanks to Travis, who was the guiding light for my three days of intense frustration and momentary triumphs. He really helped me guide my thinking into the routing oragnizational choices necesarry to make this all work.

THANKS TRAVIS!!!


#Tech Stack

Ruby, Rails, Postgresql, Git, HTML, CSS 
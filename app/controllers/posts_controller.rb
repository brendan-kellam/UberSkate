class PostsController < ApplicationController
  
  #The Index method shows all SKATE games posted. Connected to /map
  #View: /app/views/post/index.html.erb
  def index
    
    #get all posts from model
    @posts = Post.all
    
    #generate the map veiw
    gen_map(@posts)
  end
  

  #The Show method shows a individual game. Connected to /post/:id
  #View: /app/views/post/show.html.erb
  def show
    
    #get post specified by id
    @post = Post.find(params[:id])

    #generate map with only specified post
    gen_map(@post)
  end
  

  #The New method allows for the creation of a new game. Connected to /post/new
  #View: /app/views/post/new.html.erb
  def new
    
    #create new post in model
    @post = Post.new
  end
  
  #The Create method is connected to: new (see above)
  def create
    
    #create new post in model with defined parameters
    @post = Post.new(post_params)
    
    #if the post succsefuly saves
    if @post.save
      
      #redirect to index. Connected to /map
      redirect_to(:action => "index")
    
    #if the post un-succesfuly saves
    else
      
      #render a new creation page
      render("new")
    end
  end


  #The Edit method allows for a post to be eddited. Connected to /post/:id/edit
  #View: /app/views/post/edit.html.erb
  def edit
    
    #get post specified by id
    @post = Post.find(params[:id])
  end
  
  #The Update method is connected to: edit (see above)
  def update
    
    #get post specified by id
    @post = Post.find(params[:id])
    
    #update the given post with the attributes collected. If the process is sucseful, continue
    if @post.update_attributes(post_params)
      
      #redirect the user to the page.
      redirect_to(:action => "show", :id => @product.id)
    
    #if the post was undable to update, continue
    else
      
      #render the index page
      render("index")
    end
  end
  
  
  #The Delete method allows for a post to be deleted
  #View: /app/views/post/delete.html.erb
  def delete
    
    #get post specified by id
    @post = Post.find(params[:id])
  end
  
  #The Destroy method is connected to: delete (see above)
  def destroy
    
    #get post specified by id and destroy
    Post.find(params[:id]).destroy
    
    #redirect to the index page.
    redirect_to(:action => "index")  
  end
  
  def usage
      #null
  end

  #private tag (all bellow will be private methods)
  private
  
  #allows for the generation of a google map, given posts data
  def gen_map(data)
    
    #generate a jason hash for the marker structure
    @hash = Gmaps4rails.build_markers(data) do |post, marker|
      
      #set the latitude and logetude position of the marker
      marker.lat post.lat
      marker.lng post.long
      
      #define the html contents for the infowindow
      marker.infowindow "
      
      <!-- div style tag -->
      <div style=\"width: 300px; height:200px; padding:1%;\"> 
      
        <!-- contents -->
        <center><h3>#{post.title}</h3>
        <center><p>#{post.description}</p>
        
        <br>
        #{post.lat}
         | 
        #{post.long}
      </div>
      
      <form action=\"#{request.original_url}/#{post.id}\">
        <input type=\"submit\" value=\"More..\">
      </form>
      
      <%= link_to \"Profile\", controller: \"posts\", action: \"show\", id: @post.id %>
      
      "
      end
          
  end
  
  #get the parameters for a given post from model
  def post_params
    
    #require post parameters: (title, description, lat, long)
    params.require(:post).permit(:title, :description, :lat, :long, :date)
  end
  
end
class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do #=> use the force
    @pet = Pet.create(params[:pet])
    if !params["owner"]["name"].empty?
      owner = Owner.create(name: params["owner"]["name"])
      @pet.owner_id = owner.id
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find_by_id(params[:id])
    @owner = Owner.find_by_id(@pet.owner_id)
    erb :'/pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    
    if !params["owner"]["name"].empty?
      owner = Owner.create(name: params["owner"]["name"])
      @pet.owner = owner
     # binding.pry
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
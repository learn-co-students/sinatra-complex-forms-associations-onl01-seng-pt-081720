class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    if params["owner"]["name"].empty?
      owner = Owner.find_by_id(params[:pet][:owner_id])
      @pet = Pet.create(name: params["pet_name"], owner: owner)
    else
      @pet = Pet.new(name: params[:pet_name])
      @pet.owner = Owner.new(name: params[:owner][:name])
      @pet.save
    end
    
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find_by_id(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    @pet = Pet.find_by_id(params[:id])
   
    if params["owner"]["name"].empty?
      owner = Owner.find_by_id(params[:owner_id])
      @pet.update(name: params[:pet_name], owner: owner)
    else
      @pet.update(name: params[:pet_name])
      @pet.owner = Owner.create(name: params["owner"]["name"])
      @pet.save
    end

    redirect to "pets/#{@pet.id}"
  end
end
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
    @pet = Pet.create(params[:pet])
    
    if !params[:owner][:name].blank?
      @pet.owner = Owner.create(name: params[:owner][:name]) 
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all

    erb :'/pets/edit'
  end

  patch '/pets/:id' do 
    pet = Pet.find_by_id(params[:id])
    
    if !params[:owner][:name].blank?
      @owner = Owner.new(name: params[:owner][:name])
      @owner.save
      pet.owner = @owner
    else
      pet.update(name: params[:name], owner_id: params[:pet][:owner_id])
    end

    pet.save
    redirect to "pets/#{@pet.id}"
  end
end
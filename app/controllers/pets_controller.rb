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
    pet = Pet.create(params[:pet])
    owner = Owner.find_or_create_by(params[:owner][:name])

    redirect to "pets/#{pet.id}"
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
    new_pet = pet.update(name: params[:name], owner_id: params[:owner_id])
    new_pet.save
    redirect to "pets/#{@pet.id}"
  end
end
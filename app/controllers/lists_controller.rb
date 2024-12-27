class ListsController < ApplicationController
  before_action :set_list, only: %i[ show edit update destroy ]
  before_action :authorize_user!, only: %i[ show edit update destroy ]

  # GET /lists or /lists.json
  def index
    @lists = current_user.lists # Exibir apenas as listas do usuário logado
  end

  # GET /lists/1 or /lists/1.json
  def show
  end

  # GET /lists/new
  def new
    @list = List.new
  end

  # GET /lists/1/edit
  def edit
  end

  # POST /lists or /lists.json
  def create
    @list = List.new(list_params)
    @list.user = current_user # Associar a lista ao usuário logado

    respond_to do |format|
      if @list.save
        format.html { redirect_to @list, notice: "List was successfully created.", flash: { success: true } }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new, status: :unprocessable_entity, flash: { success: false } }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/1 or /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to @list, notice: "List was successfully updated.", flash: { success: true } }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit, status: :unprocessable_entity, flash: { success: false } }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1 or /lists/1.json
  def destroy
    @list.destroy!

    respond_to do |format|
      format.html { redirect_to lists_path, status: :see_other, notice: "List was successfully destroyed.", flash: { success: true } }
      format.json { head :no_content }
    end
  end

  private
    # Uso de callbacks para compartir código entre ações
    def set_list
      @list = List.find(params[:id])
    end

    # Verificar se o usuário atual é o criador da lista
    def authorize_user!
      redirect_to lists_path, notice: "You are not authorized to access this list." unless @list.user == current_user
    end

    # Apenas permitir uma lista de parâmetros confiáveis através de strong parameters
    def list_params
      params.require(:list).permit(:name)
    end
end

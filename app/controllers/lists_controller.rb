class ListsController < ApplicationController
  # Configurar callbacks para compartilhar código entre ações
  before_action :set_list, only: %i[ show edit update destroy ]
  # Verificar se o usuário atual é autorizado para acessar a lista
  before_action :authorize_user!, only: %i[ show edit update destroy ]

  # GET /lists ou /lists.json
  def index
    # Exibir apenas as listas do usuário logado com paginação de 10 por página
    @lists = current_user.lists.page(params[:page]).per(10)
    fresh_when(@lists) 
  end

  # GET /lists/1 ou /lists/1.json
  def show
    # Ação para exibir uma lista específica
  end

  # GET /lists/new
  def new
    # Inicializar uma nova lista
    @list = List.new
  end

  # GET /lists/1/edit
  def edit
    # Ação para editar uma lista específica
  end

  # POST /lists ou /lists.json
  def create
    # Criar uma nova lista associada ao usuário logado
    @list = List.new(list_params)
    @list.user = current_user

    respond_to do |format|
      if @list.save
        # Responder com sucesso na criação da lista
        format.html { redirect_to @list, notice: "List was successfully created.", flash: { success: true } }
        format.json { render :show, status: :created, location: @list }
      else
        # Responder com erro na criação da lista
        format.html { render :new, status: :unprocessable_entity, flash: { success: false } }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/1 ou /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        # Responder com sucesso na atualização da lista
        format.html { redirect_to @list, notice: "List was successfully updated.", flash: { success: true } }
        format.json { render :show, status: :ok, location: @list }
      else
        # Responder com erro na atualização da lista
        format.html { render :edit, status: :unprocessable_entity, flash: { success: false } }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1 ou /lists/1.json
  def destroy
    # Destruir a lista específica
    @list.destroy!

    respond_to do |format|
      # Responder com sucesso na destruição da lista
      format.html { redirect_to lists_path, status: :see_other, notice: "List was successfully destroyed.", flash: { success: true } }
      format.json { head :no_content }
    end
  end

  private
    # Uso de callbacks para compartilhar código entre ações
    def set_list
      @list = List.find_by(id: params[:id])
      redirect_to lists_path, notice: "List not found." if @list.nil?
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

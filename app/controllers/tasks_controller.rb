class TasksController < ApplicationController
  before_action :set_list
  before_action :authorize_user!
  before_action :set_task, only: %i[ show edit update destroy toggle_complete ]

  # GET /lists/:list_id/tasks or /lists/:list_id/tasks.json
  def index
    @tasks = @list.tasks
  end

  # GET /lists/:list_id/tasks/1 or /lists/:list_id/tasks/1.json
  def show
  end

  # GET /lists/:list_id/tasks/new
  def new
    @task = @list.tasks.build
  end

  # GET /lists/:list_id/tasks/1/edit
  def edit
  end

  # POST /lists/:list_id/tasks or /lists/:list_id/tasks.json
  def create
    @task = @list.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to [@list, @task], notice: "Task was successfully created.", flash: { success: true } }
        format.json { render :show, status: :created, location: [@list, @task] }
      else
        format.html { render :new, status: :unprocessable_entity, flash: { success: false} }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  
  # PATCH/PUT /lists/:list_id/tasks/1 or /lists/:list_id/tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to [@list, @task], notice: "Task was successfully updated.", flash: { success: true } }
        format.json { render :show, status: :ok, location: [@list, @task] }
      else
        format.html { render :edit, status: :unprocessable_entity, flash: { success: false } }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH /lists/:list_id/tasks/1/toggle_complete
  def toggle_complete
    @task.update(is_completed: !@task.is_completed)
  
    respond_to do |format|
      format.html { redirect_to list_tasks_path(@list), notice: "Task completion status was successfully toggled.", flash: { success: true } } 
      format.json { render :show, status: :ok, location: [@list, @task] }
    end
  end

  # DELETE /lists/:list_id/tasks/1 or /lists/:list_id/tasks/1.json
  def destroy
    @task.destroy!

    respond_to do |format|
      format.html { redirect_to list_tasks_path(@list), status: :see_other, notice: "Task was successfully destroyed.", flash: { success: true } } 
      format.json { head :no_content }
    end
  end

  # uso de callbacks para compartilhar informações com os métodos
  private
    # Ações para encontrar a lista específica e a tarefa específica na lista
    def set_list
      @list = List.find_by(id: params[:list_id])
      redirect_to lists_path, notice: "List not found." if @list.nil?
    end

    def set_task
      # Encontrar a tarefa específica na lista
      @task = @list.tasks.find_by(id: params[:id])
      redirect_to list_tasks_path(@list), notice: "Task not found." if @task.nil?
    end

    # Verificar se o usuário atual é o criador da lista
    def authorize_user!
      redirect_to lists_path, notice: "You are not authorized to access this list." unless @list.user == current_user
    end

    # Apenas permitir uma lista de parâmetros confiáveis através da internet.
    def task_params
      params.require(:task).permit(:name)
    end
end

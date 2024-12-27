class TasksController < ApplicationController
  allow_unauthenticated_access
  before_action :set_list
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
        format.html { redirect_to [@list, @task], notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: [@list, @task] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end


  
  # PATCH/PUT /lists/:list_id/tasks/1 or /lists/:list_id/tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to [@list, @task], notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: [@list, @task] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH /lists/:list_id/tasks/1/toggle_complete
  def toggle_complete
    @task.update(is_completed: !@task.is_completed)
  
    respond_to do |format|
      format.html { redirect_to list_tasks_path(@list), notice: "Task completion status was successfully toggled." }
      format.json { render :show, status: :ok, location: [@list, @task] }
    end
  end

  # DELETE /lists/:list_id/tasks/1 or /lists/:list_id/tasks/1.json
  def destroy
    @task.destroy!

    respond_to do |format|
      format.html { redirect_to list_tasks_path(@list), status: :see_other, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # uso de callbacks para compartilhar informações com os métodos
    def set_list
      @list = List.find(params[:list_id])
    end

    def set_task
      @task = @list.tasks.find(params[:id])
    end

    # Apenas permitir uma lista de parâmetros confiáveis através da internet.
    def task_params
      params.require(:task).permit(:name)
    end
end

class WikiDocumentsController < ApplicationController
  before_action :global_accessibility
  before_action :find_team
  before_action :find_document, only: [:edit, :update]

  def new
    @document = @team.wiki_documents.new
  end

  def create
    @document = @team.wiki_documents.new(document_params)
    if @document.save
      redirect_to wiki_documents_path
      flash[:success] = 'Вы создали документ!'
    else
      flash[:error] = record_errors(@document)
      render 'new'
    end
  end

  def index
    @documents = @team.wiki_documents
  end

  def edit; end

  def update
    if @document.update(document_params)
      redirect_to wiki_documents_path
      flash[:success] = 'Документ обновлен!'
    else
      flash[:error] = record_errors(@document)
      render 'edit'
    end
  end

  private

  def document_params
    params.require(:wiki_document).permit(:title, :body)
  end

  def find_document
    @document = WikiDocument.find(params[:id])
  end

  def find_team
    @team = current_user.team
  end
end

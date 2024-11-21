class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_note, only: %i[show edit update destroy]
  def index
  end

  def create
    @note = Note.new(note_params)

    if @note.save
      redirect_to @note, notice: 'Note was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
  end

  def update
    if @note.update(note_params)
      redirect_to @note, notice: 'Note was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def destroy
  end

  def edit
  end

  private

  # Use callbacks to set the note based on the ID
  def set_note
    @note = Note.find(params[:id])
  end

  # Only allow the `content` parameter to be passed in, as it’s the only attribute in this case
  def note_params
    params.require(:note).permit(:content)
  end
end

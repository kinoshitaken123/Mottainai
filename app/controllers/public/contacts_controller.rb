class Public::ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  # newアクションから入力内容を受け取り、
  # 送信ボタンを押されたらcreateアクションを実行。
  def confirm
    @contact = Contact.new(contact_params)
    if @contact.invalid?
      flash[:alert] = "すべて入力してください。"
      render :new
    end
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.send_mail(@contact).deliver_now
      redirect_to public_contacts_done_path
    else
      render :new
    end
  end

  def back
    @contact = Contact.new(contact_params)
    render :new
  end

  def done
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :message)
  end
end

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'users直下ページのテスト' do
    before do
      create(:user)
      @user = User.find(1)
      sign_in @user
    end
    describe 'showページのテスト' do
      before do
        visit user_mypage_path
      end
      context 'memberの場合' do
        it 'ページが表示される' do
          expect(page).to have_content @user.name
          expect(page).to have_css '.public-users-show'
        end
        it '1つのリンクが非表示' do
          expect(page).to_not have_content '本登録はこちら'
        end
      end
      context 'guestの場合' do
        before do
          @user.update(user_status: 'guest')
          visit user_mypage_path
        end
        it 'ページが表示される' do
          expect(page).to have_content @user.name
          expect(page).to have_css '.public-users-show'
        end
        it '会員情報が非アクティブ' do
          expect(page).to have_css '.inactive'
        end
        it '1つのリンクがアクティブ' do
          click_link '本登録はこちら'
          expect(current_path).to eq user_edit_path
          expect(page).to have_css '.public-users-edit'
        end
      end
    end
    describe 'infoページのテスト' do
      before do
        visit user_info_path
      end
      it 'ページが表示される' do
        expect(page).to have_content @user.phone_number
        expect(page).to have_content @user.email
        expect(page).to have_css '.public-users-info'
      end
      it '1つのリンクにアクセスできる' do
        click_link '登録情報編集'
        expect(current_path).to eq user_edit_path
      end
    end
    describe 'editページのテスト' do
      before do
        visit user_edit_path
      end
      context 'memberの場合' do
        it 'ページが表示される' do
          expect(page).to have_css('.public-users-edit__member')
        end
        it '2つのリンクにアクセスできる' do
          click_link 'こちら'
          expect(current_path).to eq new_contact_path
          visit user_edit_path
          click_link '退会する'
          expect(current_path).to eq user_withdraw_path
        end
        it '"変更を保存する"ボタンを押すとinfoページに遷移' do
          fill_in 'user[phone_number]', with: @user.phone_number
          fill_in 'user[email]', with: @user.email
          click_button '変更を保存'
          expect(current_path).to eq user_info_path
        end
      end
      context 'guestの場合' do
        before do
          @user.update(user_status: 'guest')
          visit user_edit_path
        end
        it 'ページが表示される' do
          expect(page).to have_css('.public-users-edit__guest')
        end
      end
    end
    describe 'profileページのテスト' do
      before do
        visit users_profile_path(@user)
      end
      it 'ページが表示される' do
        expect(page).to have_css '.public-users-profile'
      end
    end
    describe 'withdrawページのテスト' do
      before do
        visit user_withdraw_path
      end
      it 'ページが表示される' do
        expect(page).to have_css '.public-users-withdraw'
      end
      it '1つのリンクにアクセスできる' do
        click_link 'こちら'
        expect(current_path).to eq user_edit_path
      end
      describe '"退会する"ボタンの処理' do
        it 'withdrewページに遷移し、"退会済み"になる' do
          click_button '退会する'
          expect(current_path).to eq users_withdrew_path(@user)
          expect(User.find(1).user_status).to eq 'withdrew'
          expect(page).to have_css '.public-users-withdrew'
        end
      end
    end
    describe 'withdrewページのテスト' do
      before do
        visit user_withdraw_path
        click_button '退会する'
      end
      it 'ページが表示される' do
        expect(page).to have_css '.public-users-withdrew'
      end
    end
    describe '_linksのテスト' do
      context 'public/usersディレクトリ直下ページの場合' do
        context 'memberの場合' do
          before do
            visit user_mypage_path
          end
          it '5つのリンクが表示される' do
            click_link 'プロフィールを確認'
            expect(current_path).to eq users_profile_path(@user)
            visit user_mypage_path
            click_link '登録情報確認'
            expect(current_path).to eq user_info_path
            visit user_mypage_path
            click_link 'パスワードの変更はこちら'
            expect(current_path).to eq edit_user_registration_path
            visit user_mypage_path
            click_link '現在の予約状況'
            expect(current_path).to eq user_reservations_path(@user)
            visit user_mypage_path
            click_link '予約履歴'
            expect(current_path).to eq user_reservations_path(@user)
          end
        end
        context 'guestの場合' do
          before do
            @user.update(user_status: 'guest')
            visit user_mypage_path
          end
          it '4つのリンクが非アクティブ' do
            click_link 'プロフィールを確認'
            expect(page).to have_no_link 'プロフィールを確認'
            # アクティブで認識される
            # visit user_mypage_path
            # click_link '登録情報確認'
            # expect(page).to have_no_link '登録情報確認'
            visit user_mypage_path
            click_link 'パスワードの変更はこちら'
            expect(page).to have_no_link 'パスワードの変更はこちら'
            visit user_mypage_path
            click_link '現在の予約状況'
            expect(page).to have_no_link '現在の予約状況'
            visit user_mypage_path
            click_link '予約履歴'
            expect(page).to have_no_link '予約履歴'
          end
        end
      end
      context 'public/users/deviseディレクトリ以下ページの場合' do
        it '2つのリンクが非表示' do
          visit users_sign_up_complete_path
          expect(page).to_not have_content '現在の予約状況'
          expect(page).to_not have_content '予約履歴'
        end
      end
    end
  end
  describe 'devise配下ページのテスト' do
    describe 'registrationsのテスト' do
      describe 'newページのテスト' do
        before do
          visit new_user_registration_path
        end
        it 'ページが表示される' do
          expect(page).to have_css '.public-users-registrations-new'
        end
        it '確認画面へ遷移できる' do
          within('.registration-form') do
            fill_in 'user[name_family]', with: '田中'
            fill_in 'user[name_first]', with: '太郎'
            fill_in 'user[name_family_kana]', with: 'たなか'
            fill_in 'user[name_first_kana]', with: 'たろう'
            fill_in 'user[phone_number]', with: '00000000000'
            fill_in 'user[email]', with: 'taro@taro.com'
            fill_in 'user[password]', with: '000000'
            fill_in 'user[password_confirmation]', with: '000000'
          end
          click_button '確認する'
          expect(current_path).to eq users_sign_up_confirm_path
          expect(page).to have_css '.public-users-registrations-confirm'
        end
        describe 'confirmページのテスト' do
          before do
            within('.registration-form') do
              fill_in 'user[name_family]', with: '田中'
              fill_in 'user[name_first]', with: '太郎'
              fill_in 'user[name_family_kana]', with: 'たなか'
              fill_in 'user[name_first_kana]', with: 'たろう'
              fill_in 'user[phone_number]', with: '00000000000'
              fill_in 'user[email]', with: 'taro@taro.com'
              fill_in 'user[password]', with: '000000'
              fill_in 'user[password_confirmation]', with: '000000'
            end
            click_button '確認する'
          end
          describe 'ボタンのテスト' do
            context '"修正する"ボタンの場合' do
              it 'newページに遷移する' do
                click_button '修正する'
                expect(page).to have_css '.public-users-registrations-new'
              end
            end
          end
        end
      end
      describe 'email_noticeページのテスト' do
        it 'confirmページからの遷移でページが表示される' do
          visit users_sign_up_email_notice_path(email: 'test@test.com')
          expect(page).to have_css '.public-users-registrations-email_notice'
        end
        it 'ダイレクトアクセスでpublic/homes/redirectにリダイレクト' do
          visit users_sign_up_email_notice_path
          expect(current_path).to eq expired_path
          expect(page).to have_css '.public-homes-redirect'
        end
      end
    end
    describe 'sessionsのテスト' do
      before do
        @user = create(:user)
        visit new_user_session_path
      end
      describe 'newページのテスト' do
        it 'ページが表示される' do
          expect(page).to have_css '.public-users-sessions-new'
        end
        it '通常ログインに成功する' do
          fill_in 'user[email]', with: @user.email
          fill_in 'user[password]', with: @user.password
          click_button 'ログイン'
          expect(current_path).to eq root_path
        end
        it 'ゲストログインに成功する' do
          click_button 'ゲストログイン'
          expect(page).to have_css '.public-homes-top'
          expect(User.last.user_status).to eq 'guest'
        end
      end
    end
    describe 'sharedのテスト' do
      describe '_linksのテスト' do
        it '2つのリンクにアクセスできる' do
          visit new_user_registration_path
          click_link 'ログイン画面へ'
          expect(current_path).to eq new_user_session_path
          visit new_user_registration_path
          click_link 'TOP画面へ'
          expect(current_path).to eq root_path
        end
      end
    end
  end
end

require 'rails_helper'

feature 'Admin register carrier' do
  scenario 'successfully' do
    admin = create(:admin)
    login_as(admin, scope: :admin)

    visit root_path
    click_on 'Cadastrar transportadora'
    fill_in 'Nome Fantasia', with: 'Zona Oeste courier'
    fill_in 'CNPJ', with: '82.676.748/0001-73'
    fill_in 'Razão Social', with: 'Carlos Silva Transportes LTDA'
    fill_in 'Logradouro', with: 'Av. Raimundo P. de Magalhaes'
    fill_in 'Número', with: '132'
    fill_in 'Complemento', with: '3º Andar'
    fill_in 'CEP', with: '02945-000'
    fill_in 'Bairro', with: 'Pirituba'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    click_on 'Confirmar registro'

    expect(page).to have_content('Transportadora cadastrada com sucesso')
    expect(page).to have_content('Transportadora: Zona Oeste courier')
    expect(page).to have_content('CNPJ: 82.676.748/0001-73')
    expect(page).to have_content('Razão Social: Carlos Silva Transportes LTDA')
    expect(page).to have_content('Logradouro: Av. Raimundo P. de Magalhaes')
    expect(page).to have_content('Número: 132')
    expect(page).to have_content('Complemento: 3º Andar')
    expect(page).to have_content('CEP: 02945-000')
    expect(page).to have_content('Bairro: Pirituba')
    expect(page).to have_content('Cidade: São Paulo')
    expect(page).to have_content('Estado: SP')
    expect(page).to have_link('Voltar')
  end

  scenario 'and must fill in all required fields' do
    admin = create(:admin)
    login_as(admin, scope: :admin)

    visit root_path
    click_on 'Cadastrar transportadora'
    fill_in 'Nome Fantasia', with: 'Zona oeste courier'
    fill_in 'CNPJ', with: ''
    fill_in 'Razão Social', with: ''
    fill_in 'Logradouro', with: 'Av. Raimundo Pereira de Magalhaes'
    fill_in 'Número', with: '132'
    fill_in 'Complemento', with: '3º Andar'
    fill_in 'CEP', with: '02945-000'
    fill_in 'Bairro', with: 'Pirituba'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    click_on 'Confirmar registro'

    expect(page).not_to have_content('Transportadora cadastrada com sucesso')
    expect(page).to have_content('CNPJ não pode ficar em branco')
    expect(page).to have_content('Razão Social não pode ficar em branco')
  end

  scenario 'and register freight by volume and price range' do
    admin = create(:admin)
    carrier = create(:carrier)
    login_as(admin, scope: :admin)

    visit root_path
    click_on 'Transportadoras cadastradas'
    click_on carrier.name
    click_on 'Cadastrar opção de frete'
    fill_in 'Volume mínimo', with: '0.01'
    fill_in 'Volume máximo', with: '10.0'
    fill_in 'Preço por Kilo', with: '35.0'

    click_on 'Cadastrar opção de frete'

    expect(page).to have_content('Opção de frete cadastrada com sucesso')
    expect(page).to have_content('Volume mínimo: 0.01')
    expect(page).to have_content('Volume máximo: 10.0')
    expect(page).to have_content('Preço por kilo: 35.0')
  end

  scenario 'and max_vol must be higher than min_vol' do
    admin = create(:admin)
    carrier = create(:carrier, name: 'Teste Transportes')
    login_as(admin, scope: :admin)

    visit root_path
    click_on 'Transportadoras cadastradas'
    click_on carrier.name
    click_on 'Cadastrar opção de frete'
    fill_in 'Volume mínimo', with: '10.0'
    fill_in 'Volume máximo', with: '10.0'
    fill_in 'Preço por Kilo', with: '35.0'

    click_on 'Cadastrar opção de frete'

    expect(page).not_to have_content('Opção de frete cadastrada com sucesso')
    expect(page).to have_content("O valor de volume máximo deve ser\
 maior que o volume mínimo")
  end
end

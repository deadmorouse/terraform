2. Изучите файл **.gitignore**. В каком terraform-файле, согласно этому .gitignore, допустимо сохранить личную, секретную информацию?
Ответ: personal.auto.tfvars

3. Выполните код проекта. Найдите  в state-файле секретное содержимое созданного ресурса **random_password**, пришлите в качестве ответа конкретный ключ и его значение.
Ответ: "result": M1y21B3Mdiv1JC3P

4. Раскомментируйте блок кода, примерно расположенный на строчках 29–42 файла main.tf. Выполните команду terraform validate. Объясните, в чём заключаются намеренно допущенные ошибки. Исправьте их.
Ответ: при выполнения кода вышли следующие ошибки:
изображение 1:  
![1 ошибка](https://github.com/deadmorouse/terraform/assets/49486347/5876f614-563c-4714-9cd4-49d71a158602)  
на 1 изображении
  1) первая ошибка связана тем, что не было в строке resource указан name
  2) вторая ошибка - опечатка в 1nginx

изображение 2:  
![2 ошибка](https://github.com/deadmorouse/terraform/assets/49486347/5a331c33-1609-475b-9e11-623f14721f69)
на 2 изображении  
  3) третья ошибка - нужно в строке image указать name, которое мы задали при исправлении первой ошибки  
  4) четвертая ошибка - _FAKE нужно убрать; resulT - исправить T на нижний регистр  

5. Выполните код. В качестве ответа приложите: исправленный фрагмент кода и вывод команды ```docker ps```.

Изображение 3:  
![correct_code1](https://github.com/deadmorouse/terraform/assets/49486347/5874ea68-d562-4706-80e6-ee706e99f54f)
Изображение исправленного кода

Изображение 4:  
![docker_ps_terr](https://github.com/deadmorouse/terraform/assets/49486347/8e4427d8-9317-44a5-ba8f-326fdc06ba5a)  

6. Замените имя docker-контейнера в блоке кода на ```hello_world```. Не перепутайте имя контейнера и имя образа. Мы всё ещё продолжаем использовать name = "nginx:latest". Выполните команду ```terraform apply -auto-approve```.
Объясните своими словами, в чём может быть опасность применения ключа  ```-auto-approve```. Догадайтесь или нагуглите зачем может пригодиться данный ключ? В качестве ответа дополнительно приложите вывод команды ```docker ps```.
Ответ:
 Изображение 5:  
![uncorrected_code2](https://github.com/deadmorouse/terraform/assets/49486347/4d890222-764b-4fe4-9ab0-de864761fa4a)


На изображении 5 показан вывод при выполнении команд terraform apply -auto-approve и docker ps

Опасность при выполнении terraform apply -auto-approve заключается в незамедлительном выполнении без согласования (подтверждения). В случае неисправности (ошибок) в коде образ будет затерт.  
Я предполагаю, данный ключ полезен при автоматизации процесса управления объектами в большой инфраструктуре.  

7. Уничтожьте созданные ресурсы с помощью **terraform**. Убедитесь, что все ресурсы удалены. Приложите содержимое файла **terraform.tfstate**.
   Изображение 6
![ter_destroy](https://github.com/deadmorouse/terraform/assets/49486347/2193188e-a8d0-4ebc-b34d-dd65118f657d)

   Изображение 7
![tfstate_destroy](https://github.com/deadmorouse/terraform/assets/49486347/59caa39a-458e-41ca-a7ae-d7617adbbf57)

8. Объясните, почему при этом не был удалён docker-образ **nginx:latest**. Ответ **обязательно** подкрепите строчкой из документации [**terraform провайдера docker**](https://docs.comcloud.xyz/providers/kreuzwerker/docker/latest/docs).
Ответ: 
keep_locally (Boolean) If true, then the Docker image won't be deleted on destroy operation. If this is false, it will delete the image from the docker local storage on destroy operation.





<%-- 
    Document   : cardMess
    Created on : 22 Feb, 2024, 7:40:56 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
              integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    </head>
    <style>
            #cart-mess {
                position: fixed;
                top: 100px;
                right: 0;
                z-index: 10000;
            }

            .cart-mess {
                margin-top: 15px;
                min-width: 400px;
                padding: 15px 20px;
                border-radius: 10px;
                transition: all linear 0.3s;
            }

            .cart-mess.cart-mess_success {
                background-color: #03a935;
                color: #fff;
            }

            .cart-mess.cart-mess_error {
                background-color: #a90316;
                color: #fff;
            }
            
            .cart-mess.cart-mess_warning {
                background-color: #d2d0d0;
                color: #333;
            }
            @keyframes slideShow {
                from {
                    opacity: 0;
                    transform: translateX(100%);
                }

                to {
                    opacity: 1;
                    transform: translateX(0);
                }
            }

            @keyframes fadeOut {
                to {
                    opacity: 0;
                }
            }
        </style>
    <body>
        <div id="cart-mess">

        </div>
    </body>
    <script>
    function showMess({
        type = 'success',
        title = '',
        duration = 3000
    }) {
        const iconMess = {
            success: 'bx bxs-check-circle',
            error: 'bx bxs-x-circle',
            warning: 'bx bx-info-circle'
        };
        const icon = iconMess[type];
        const cartBox = document.getElementById('cart-mess')
        if (cartBox) {
            const cartMess = document.createElement('div');
            const delay = (duration / 1000).toFixed(2)
            cartMess.classList.add('cart-mess', "cart-mess_" + type)
            cartMess.style.animation = `slideShow ease .3s, fadeOut linear 1s `+delay+`s forward;`
            cartMess.innerHTML = `<div class="d-flex align-items-center">
            <div class="cart-mess_head me-3">
                <i class='` + icon + ` text-white' style="font-size: 30px;"></i>
            </div>
            <div class="cart-mess_content fs-4 text-center">
                ` + title + `
            </div>
        </div>`;
            cartBox.appendChild(cartMess)
            setTimeout(() => {
                cartBox.removeChild(cartMess)
            }, duration + 1000);
        }
    }
    </script>
</html>

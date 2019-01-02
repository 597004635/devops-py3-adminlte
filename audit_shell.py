import os, sys

if __name__ == "__main__":
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "devops.settings")
    import django
    django.setup()
    from audit.unit.user_interactive import UserShell
    obj = UserShell(sys.argv)
    obj.start()

    # user_name = sys.argv[1]
    # obj.start(user_name)


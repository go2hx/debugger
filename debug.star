def main():
    print('debug start')
    dlv_command("transcript -x -t output.txt")
    print("#breakpoints")
    for f in functions().Funcs:
        v = f.split('.')
        if len(v) != 2:
            continue
        if v[1][0] < 'a' or v[1][0] > 'z':
            continue
        if "runtime" in v[0] or "internal" in v[0] or "sync" in v[0] or "os" in v[0]:
            continue
        print(f)
        i = -1
        while True:
            v = create_breakpoint({ "FunctionName": f, "Line": i })
            i += 1
            print("i:",i)
            if v != None:
                break
    print("%----%")
    while True:
        v = dlv_command("continue")
        print(v)
        if v != None:
            break
        print("#LOCALS")
        for v in local_vars().Variables:
            print(v)
        dlv_command("locals")
        print("#VARS")
        for v in package_vars().Variables:
            print(v)
        #dlv_command("vars")
        print("%----%")
    print("exiting...")